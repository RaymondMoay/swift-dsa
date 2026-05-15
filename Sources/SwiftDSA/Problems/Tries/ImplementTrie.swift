//
//  ImplementTrie.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 208 — Implement Trie (Prefix Tree)
//
//  A trie (pronounced "try") is a tree data structure used to efficiently
//  store and retrieve keys in a set of strings. It is the canonical structure
//  behind search-as-you-type, autocomplete, and prefix search — exactly the
//  shape you would use for a payee/contact lookup in a payments app.
//
//  Implement the `PrefixTrie` class with the following API:
//    - init()                          — initialise an empty trie
//    - insert(_ word: String)          — insert `word` into the trie
//    - search(_ word: String) -> Bool  — true iff `word` was previously inserted
//    - startsWith(_ prefix: String) -> Bool
//                                      — true iff any inserted word starts with `prefix`
//
//  (Named `PrefixTrie` here to avoid colliding with the existing
//   `Trie` data-structure scratch file in Sources/SwiftDSA/Data Structures.)
//
//  Constraints:
//    - 1 <= word.count, prefix.count <= 2000
//    - word and prefix consist of lowercase English letters.
//    - At most 3 * 10^4 calls in total to insert/search/startsWith.
//
//  Hints:
//    - Each TrieNode holds 26 child pointers (one per lowercase letter) and a
//      bool flag `isEnd` to mark word terminations.
//    - Walking a word of length L costs O(L) — independent of how many words
//      are stored. This is the trie's defining property and the reason it
//      beats a HashSet for *prefix* queries.
//
//  Target:
//    Time:  O(L) per operation, where L = length of the input word/prefix.
//    Space: O(N * L) total, where N = number of inserted words.
//
//  Interviewer hint (concept check):
//    Be ready to defend the choice of array-of-26 children vs. a dictionary.
//    Array is faster + lower per-node overhead for a known small alphabet;
//    dictionary is the right call for Unicode or unknown alphabets.

final class PrefixTrie {
    
    class Node<Value: Hashable> {
        var value: Value
        var isWord: Bool
        var children: [Value: Node]
        
        init(value: Value, isWord: Bool, children: [Value : Node]) {
            self.value = value
            self.isWord = false
            self.children = children
        }
    }
    
    let root: Node<Character>

    init() {
        self.root = Node(value: "-", isWord: false, children: [:])
    }

    func insert(_ word: String) {
        var curr: Node<Character> = root
        for s in word {
            if let node = curr.children[s] {
                curr = node
                continue
            }
            // add the children...
            let newNode = Node<Character>(
                value: s,
                isWord: false,
                children: [:]
            )
            curr.children[s] = newNode
            curr = newNode
        }
        curr.isWord = true
    }
    
    // r - c - a

    // "cat"
    func search(_ word: String) -> Bool {
        var curr = root
        for s in word {
            guard let nextNode = curr.children[s] else {
                return false
            }
            curr = nextNode
        }
        return curr.isWord
    }
    
    
    func startsWith(_ prefix: String) -> Bool {
        var curr = root
        for s in prefix {
            guard let nextNode = curr.children[s] else {
                return false
            }
            curr = nextNode
        }
        return true
    }
}
