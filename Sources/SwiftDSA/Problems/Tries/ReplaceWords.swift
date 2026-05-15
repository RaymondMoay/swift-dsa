//
//  ReplaceWords.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 648 — Replace Words
//
//  In English, a *derivative* is a word formed by appending a suffix to a
//  *root*. For example, "help" is a root and "helpful" is a derivative.
//
//  You are given a dictionary of roots and a sentence. Replace every
//  derivative in the sentence with the **shortest root** that forms it. If a
//  derivative can be replaced by more than one root, choose the shortest. If
//  a word has no matching root in the dictionary, leave it unchanged.
//
//  Return the resulting sentence.
//
//  Example:
//    dictionary = ["cat", "bat", "rat"]
//    sentence   = "the cattle was rattled by the battery"
//    output     = "the cat was rat by the bat"
//
//  Constraints:
//    1 <= dictionary.count <= 1000
//    1 <= dictionary[i].count <= 100
//    Sentence consists of lowercase words separated by single spaces.
//    1 <= sentence.count <= 10^6
//    1 <= sentence words count <= 1000
//
//  Why this matters for payments:
//    Models prefix-based classification — for example, mapping a transaction
//    merchant string ("starbucks_sg_orchard_road") onto the shortest known
//    merchant root ("starbucks") for grouping in the spend-by-merchant view.
//
//  Approaches:
//    1) Brute force: for each word in the sentence, try every dictionary root
//       and check if it is a prefix. O(W * D * L). Bad.
//
//    2) **Trie approach (this is the lesson)**:
//       Insert every root into a trie, marking the end of each root with a
//       boolean flag. For each word in the sentence, walk the trie one
//       character at a time and stop at the first node flagged as a word end
//       — that is, by construction, the shortest matching root.
//       Time:  O(D * L) build + O(N) total to scan the sentence (where N is
//              the total number of characters in the sentence).
//       Space: O(D * L) for the trie.
//
//  Interviewer hint:
//    Talk through the "stop at the first end-of-root marker" insight aloud —
//    that's the cute observation the interviewer is looking for, and it falls
//    straight out of the trie's structure.

struct ReplaceWords {
    
    class Trie {
        
        class Node {
            let value: Character
            var children: [Node?]
            var isWord: Bool
            
            init(value: Character) {
                self.value = value
                self.children = Array(repeating: nil, count: 26)
                self.isWord = false
            }
        }
        
        let root: Node = Node(value: "-")
        
        init() { }
        
        // r - C - A - T
        func insert(_ word: String) {
            var curr = root
            for s in word {
                let sIndex = index(of: s)
                if let nextNode = curr.children[sIndex] {
                    curr = nextNode
                    continue
                } else {
                    let newNode = Node(value: s)
                    curr.children[sIndex] = newNode
                    curr = newNode
                }
            }
            curr.isWord = true
        }
        
        func suggest(_ prefix: String) -> String? {
            
            // Get the deepest root node to start DFS from
            var rootNode = root
            for s in prefix {
                let sIndex = index(of: s)
                if let nextNode = rootNode.children[sIndex] {
                    rootNode = nextNode
                } else {
                    return nil
                }
            }
            
            // DFS the root node
            // Return the first isWord, no need to get an array. Goal is to return the shortest!
            var answer: String? = nil
            func walk(curr: Node, prefix: String) {
                // base
                if answer != nil { return } // return early if an answer is found, so we stop recursing deeper...
                
                if curr.isWord {
                    answer = prefix
                    return
                }
                
                // recurse
                for child in curr.children {
                    guard let child else { continue }
                    let newPrefix = prefix + String(child.value)
                    walk(curr: child, prefix: newPrefix)
                }
            }
            
            walk(curr: rootNode, prefix: prefix)
            return answer
        }
        
        // MARK: Helper
        
        func index(of c: Character) -> Int {
            Int(c.asciiValue! - Character("a").asciiValue!)
        }
    }

    static func perform(_ dictionary: [String], _ sentence: String) -> String {
        
        /// 1. Create a Trie and add dictionary words into the trie
        ///
        
        let trie = Trie()
        for word in dictionary {
            trie.insert(word)
        }
        
        /// 2. Loop the sentence, loop the characters in the word -> every iteration, we get suggestions from the trie.
        ///     - Once we get the suggestion, the shortest suggestion immediately used to replace. Worst case = run through the whole word, best case, first character = shortest suggestion.
        /// Runtime: O(N) where N is number of words. The O(word) is limited to 1000 in the worst case.
        
        var words = sentence.split(separator: " ").map { String($0) }
        
        for i in 0..<words.count {
            var prefix: String = ""
            var replacement: String? = nil
            for c in words[i] {
                prefix += String(c)
                if let answer = trie.suggest(prefix) {
                    replacement = answer
                    break
                }
            }
            if let replacement, words[i].contains(replacement) {
                words[i] = replacement
            }
        }
        
        return words.joined(separator: " ")
    }
}
