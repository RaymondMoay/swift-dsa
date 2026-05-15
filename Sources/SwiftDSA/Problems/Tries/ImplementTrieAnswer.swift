//
//  ImplementTrieAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 208 — Implement Trie (Prefix Tree).
///
/// Uses a fixed-size 26-slot array of children per node. This is faster and
/// lower-overhead than a `[Character: Node]` dictionary because the alphabet
/// is small and known at compile time.
///
/// Time:  O(L) per insert / search / startsWith, where L = word length.
/// Space: O(N * L) worst case across all inserted words.
final class PrefixTrieAnswer {

    final class Node {
        var children: [Node?] = Array(repeating: nil, count: 26)
        var isEnd: Bool = false
    }

    private let root = Node()
    private static let a = UInt8(ascii: "a")

    init() {}

    func insert(_ word: String) {
        var node = root
        for byte in word.utf8 {
            let idx = Int(byte - Self.a)
            if let next = node.children[idx] {
                node = next
            } else {
                let newNode = Node()
                node.children[idx] = newNode
                node = newNode
            }
        }
        node.isEnd = true
    }

    func search(_ word: String) -> Bool {
        guard let node = findNode(for: word) else { return false }
        return node.isEnd
    }

    func startsWith(_ prefix: String) -> Bool {
        return findNode(for: prefix) != nil
    }

    /// Walks the trie following the characters of `key`. Returns the node
    /// reached if the full path exists, otherwise nil.
    private func findNode(for key: String) -> Node? {
        var node = root
        for byte in key.utf8 {
            let idx = Int(byte - Self.a)
            guard let next = node.children[idx] else { return nil }
            node = next
        }
        return node
    }
}
