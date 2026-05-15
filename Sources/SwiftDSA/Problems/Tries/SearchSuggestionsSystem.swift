//
//  SearchSuggestionsSystem.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 1268 — Search Suggestions System
//
//  You are given an array of strings `products` and a string `searchWord`.
//  Design a system that suggests at most **three** product names from `products`
//  after each character of `searchWord` is typed. Suggested products should
//  have a common prefix with the string typed so far. If there are more than
//  three products with a common prefix, return the three lexicographically
//  smallest ones.
//
//  Return a list of lists of suggested products, one list per prefix length.
//
//  Example:
//    products   = ["mobile","mouse","moneypot","monitor","mousepad"]
//    searchWord = "mouse"
//    output =
//      [["mobile","moneypot","monitor"],     // after typing "m"
//       ["mobile","moneypot","monitor"],     // after typing "mo"
//       ["mouse","mousepad"],                // after typing "mou"
//       ["mouse","mousepad"],                // after typing "mous"
//       ["mouse","mousepad"]]                // after typing "mouse"
//
//  Constraints:
//    1 <= products.count <= 1000
//    1 <= products[i].count, searchWord.count <= 3000
//    Lowercase English letters only.
//
//  Why this matters for payments:
//    This is the canonical model for the payee / contact lookup field in
//    Google Pay — "show me the top 3 saved payees as I type the recipient".
//
//  Suggested approaches:
//    1) Sort `products`, then for each prefix run a binary search and take
//       up to three lexicographically-smallest matches.
//       Time:  O(P log P) sort + O(W * log P) per typed character.
//       Space: O(1) extra (besides the sorted array).
//
//    2) **Trie approach (the one we want for this section)**:
//       Insert every product into a trie. At each node, store (a precomputed
//       cache of) up to three lexicographically smallest words passing through
//       it. To answer queries, walk the trie one character at a time, reading
//       the cached top-3 at the current node.
//       Time:  O(sum of product lengths) to build + O(W) per query character.
//       Space: O(sum of product lengths * 3).
//
//  Interviewer hint:
//    The trie approach trades a small amount of build-time work and memory for
//    O(1) per-keystroke lookups. That's the right trade-off for a UI input
//    that fires on every keystroke and must feel instantaneous.

struct SearchSuggestionsSystem {
    
    // METHOD
    
    // 1. Create a trie
    
    // 2. Instantiate the trie and insert all products into the Trie
    
    // 3. Create a function in the trie `fn suggestions` -> max 3 potential words
    
    // ASSUMPTIONS
    
    // 1. Is this english language only? -> NO.
    
    class Node {
        let value: String
        var isWord: Bool
        var children: [Node?]
        
        init(value: String, isWord: Bool = false) {
            self.value = value
            self.isWord = isWord
            self.children = Array(repeating: nil, count: 26)
        }
    }
    
    class ProductTrie {
        
        let root: Node
        
        init() {
            self.root = Node(value: "")
        }
        
        // r - M - o - u - s - e*
        //           - m*
        
        func insert(_ word: String) {
            var curr = root
            for s in word {
                let sIdx = index(of: s)
                if let nextNode = curr.children[sIdx] {
                    curr = nextNode
                    continue
                }
                let newNode = Node(value: String(s))
                curr.children[sIdx] = newNode
                curr = newNode
            }
            curr.isWord = true
        }
        
        // r - M - o - u - s - e*
        //           - m* - m - y*
        
        // "Mo"
        func suggest(_ prefix: String) -> [String] {
            var result: [String] = []
            
            // 1. loop to find the node to start DFS-ing from
            var rootNode = root
            for s in prefix {
                let sIdx = index(of: s)
                guard let nextNode = rootNode.children[sIdx] else {
                    return []
                }
                rootNode = nextNode
            }
            
            // 2. DFS the loop, add to result, early return
            
            func findWords(curr: Node, prefix: String) {
                // base
                // 1. have i reached capacity?
                if result.count == 3 { return }
                if curr.isWord {
                    result.append(prefix)
                }
                // Recurse
                for child in curr.children { // lexicographic order or DFS depth
                    guard let child else { continue }
                    let newPrefix = prefix + String(child.value)
                    findWords(curr: child, prefix: newPrefix)
                }
            }
            
            findWords(curr: rootNode, prefix: prefix)
            
            return result
        }
        
        // MARK: Helper
        
        func index(of s: Character) -> Int {
            Int(s.asciiValue! - Character("a").asciiValue!)
        }
    }

    static func perform(_ products: [String], _ searchWord: String) -> [[String]] {
        
        let trie = ProductTrie()
        for product in products {
            trie.insert(product)
        }
        
        var result: [[String]] = []
        
        var prefix: String = ""
        for s in searchWord {
            prefix += String(s)
            result.append(trie.suggest(prefix))
        }
        
        return result
    }
}
