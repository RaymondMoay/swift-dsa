//
//  PayeeAutocompleteCache.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// # Problem: Payee Autocomplete Cache (Trie-backed)
///
/// In the Google Pay "Send to" screen, the user starts typing a payee name and
/// the app shows the most likely candidates from their saved-payee list. The
/// candidates should be ordered by **how often the user has paid that payee**,
/// not just alphabetically — sending money to "Mum" twice a week should rank
/// above "Marcus" who you paid once last year.
///
/// Build an in-memory autocomplete cache that supports:
///
/// - `record(payeeName:)`
///   - Notes that the user has just sent money to `payeeName`. If the payee
///     was already in the cache, its frequency increases by 1; otherwise it
///     is added with frequency 1.
///
/// - `suggest(prefix:limit:) -> [String]`
///   - Returns up to `limit` payee names that start with `prefix`, ordered by
///     descending frequency. Ties are broken lexicographically (ascending).
///     If no payee matches the prefix, returns an empty array.
///
/// ## Constraints
/// - Payee names are non-empty strings of lowercase English letters.
/// - `limit >= 0`. A `limit` of 0 always returns `[]`.
/// - Expect thousands of `record` calls and `suggest` calls per session.
///
/// ## Why a Trie (not just a dictionary)?
/// - A `[String: Int]` frequency map gives O(1) `record`, but `suggest` would
///   have to scan every key to filter by prefix — O(N * L) per keystroke.
/// - A Trie gives O(L) to reach the prefix node, then a DFS visits only the
///   subtree rooted at that node — bounded by the number of payees that
///   *actually* share the prefix.
/// - For a typing UI that fires on every keystroke, this is the difference
///   between janky and instantaneous.
///
/// ## Example
/// ```
/// let cache = PayeeAutocompleteCache()
/// cache.record(payeeName: "mum")
/// cache.record(payeeName: "mum")
/// cache.record(payeeName: "marcus")
/// cache.record(payeeName: "ming")
///
/// cache.suggest(prefix: "m", limit: 3)  // ["mum", "marcus", "ming"]
/// // mum has the highest frequency (2). marcus and ming tie at 1, so they
/// // are returned in lexicographic order.
///
/// cache.suggest(prefix: "mu", limit: 5) // ["mum"]
/// cache.suggest(prefix: "z",  limit: 5) // []
/// ```
///
/// ## Interviewer hint (concept check for L4)
/// You should be able to explain WHY the Trie's structure makes prefix
/// lookups cheap (you only descend into the subtree the user has narrowed
/// down to) and WHEN this beats a simple dictionary (only when prefix queries
/// dominate — which is exactly the autocomplete case).
///
/// You should also be able to discuss the trade-off of pre-computing the
/// top-K at each node on every `record` (faster `suggest`, slower `record`,
/// more memory) vs. computing it lazily via DFS on each `suggest` (the
/// approach used here). Either is defensible — what matters is that you
/// articulate the trade-off out loud.

final class PayeeAutocompleteCache {
    
    /// 1. Whenever we record, increment popularity score
    /// 2. When we retrive, DFS to retrive ALL possible completion (we can't stop halfway,, then push it up into an array)
    /// 3. Before returning the array, we sort them

    class Node {
        let value: Character
        var children: [Node?]
        var isName: Bool
        var usage: Int
        
        init(value: Character) {
            self.value = value
            self.children = Array(repeating: nil, count: 26)
            self.isName = false
            self.usage = 0
        }
    }
    
    let root = Node(value: "-")

    func record(payeeName: String) {
        var curr = root
        for c in payeeName {
            let cIndex = index(of: c)
            if let nextNode = curr.children[cIndex] {
                curr = nextNode
                continue
            }
            let newNode = Node(value: c)
            curr.children[cIndex] = newNode
            curr = newNode
        }
        curr.isName = true
        curr.usage += 1
    }

    func suggest(prefix: String, limit: Int) -> [String] {
        
        var rootNode = root
        for c in prefix {
            let cIndex = index(of: c)
            if let nextNode = rootNode.children[cIndex] {
                rootNode = nextNode
            } else {
                return []
            }
        }
        
        struct ResultNode {
            let usage: Int
            let value: String
        }
        
        var results: [ResultNode] = []
        
        func walk(curr: Node, prefix: String) {
            // base case
            
            if curr.isName {
                results.append(ResultNode(usage: curr.usage, value: prefix))
            }
            
            // recurse
            for child in curr.children {
                guard let child else { continue }
                let newPrefix = prefix + String(child.value)
                walk(curr: child, prefix: newPrefix)
            }
        }
        
        walk(curr: rootNode, prefix: prefix)
        
        return results
            .sorted(by: { $0.usage > $1.usage })
            .prefix(limit)
            .map { $0.value }
    }
    
    // MARK: Helper
    
    private func index(of c: Character) -> Int {
        Int(c.asciiValue! - Character("a").asciiValue!)
    }
}
