//
//  Trie.swift.swift
//  SwiftDSA
//
//  Created by Ray on 6/5/26.
//

class TrieAnswer {
    
    class Node {
        var isWord: Bool = false
        var children: [Character: Node] = [:]
    }
    
    let root: Node = .init()
    
    func insert(word: String) {
        var node = root
        for s in word {
            if let existingNode = node.children[s] {
                node = existingNode
            } else {
                let newNode = Node()
                node.children[s] = newNode
                node = newNode
            }
        }
        node.isWord = true
    }
    
    func autocomplete(_ prefix: String) -> [String] {
        // first find the root node
        var head: Node = root
        for c in prefix {
            guard let nextNode = head.children[c] else { return [] } // new word, no autocomplete
            head = nextNode
        }
        
        var results: [String] = []
        
        // then, recurse to find all words
        func walk(curr: Node?, prefix: String, results: inout [String]) {
            // base case
            guard let curr else { return }
            
            // recurse
            // pre-
            if curr.isWord {
                results.append(prefix)
            }
            // recurse
            for c in curr.children.keys {
                let newPrefix = prefix + String(c)
                walk(curr: curr.children[c]!, prefix: newPrefix, results: &results)
            }
            // post
        }
        
        walk(curr: head, prefix: prefix, results: &results)
        
        return results
    }
    
    func search(prefix: String) -> Bool {
        var node = root
        for c in prefix {
            guard let childNode = node.children[c] else { return false }
            node = childNode
        }
        return true
    }

    // Returns true only if word was inserted exactly (not just a prefix of an inserted word)
    func contains(word: String) -> Bool {
        var node = root
        for s in word {
            guard let childNode = node.children[s] else { return false}
            node = childNode
        }
        return node.isWord
    }

    // Removes a word; prunes nodes that are no longer part of any word
    func delete(word: String) {
        func walk(curr: Node?, word: String, offset: Int) -> Bool {
            // base case
            guard let curr else { return false }
            if curr.isWord && offset == word.count - 1 {
                curr.isWord = false // always set word to false here for the last node
                return true
            }
            
            // recurse
            
            // pre
            let nextOffset = offset + 1

            if nextOffset >= word.count { return false }
            
            let character = word[word.index(word.startIndex, offsetBy: nextOffset)]
            guard let nextNode = curr.children[character] else { return false }
            
            // recurse
            if walk(curr: nextNode, word: word, offset: nextOffset) {
                // post
                if nextNode.children.isEmpty && nextNode.isWord == false {
                    curr.children[character] = nil
                    return true
                }
            }
            
            return false
        }
        
        _ = walk(curr: root, word: word, offset: -1)
    }
}
