//
//  ReplaceWordsAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 648 — Replace Words.
///
/// Strategy: insert every dictionary root into a trie, flagging the terminal
/// node of each root. For each sentence word, walk the trie character by
/// character. The moment we hit a node flagged as a root end, that's the
/// shortest matching root — emit it. If we walk off the trie before finding a
/// root end, the word has no match and we keep it as-is.
///
/// Time:  O(D * L + N) — D dictionary words of length L, sentence length N.
/// Space: O(D * L) for the trie.
struct ReplaceWordsAnswer {

    private final class Node {
        var children: [Node?] = Array(repeating: nil, count: 26)
        var isRootEnd: Bool = false
    }

    private static let a = UInt8(ascii: "a")

    static func perform(_ dictionary: [String], _ sentence: String) -> String {
        let root = buildTrie(dictionary)
        let words = sentence.split(separator: " ", omittingEmptySubsequences: false)
        let replaced = words.map { shortestRoot(for: $0, root: root) }
        return replaced.joined(separator: " ")
    }

    private static func buildTrie(_ dictionary: [String]) -> Node {
        let root = Node()
        for word in dictionary {
            var node = root
            for byte in word.utf8 {
                let idx = Int(byte - a)
                if let next = node.children[idx] {
                    node = next
                } else {
                    let newNode = Node()
                    node.children[idx] = newNode
                    node = newNode
                }
            }
            node.isRootEnd = true
        }
        return root
    }

    /// Walks `word` through the trie. Returns the shortest matching root, or
    /// the word itself if no root matches.
    private static func shortestRoot(for word: Substring, root: Node) -> String {
        var node = root
        var prefixLength = 0
        for byte in word.utf8 {
            let idx = Int(byte - a)
            guard let next = node.children[idx] else {
                return String(word)
            }
            prefixLength += 1
            if next.isRootEnd {
                return String(word.prefix(prefixLength))
            }
            node = next
        }
        // Walked through the entire word without ever hitting a root end.
        return String(word)
    }
}
