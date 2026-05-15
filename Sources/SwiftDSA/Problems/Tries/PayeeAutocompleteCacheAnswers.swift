//
//  PayeeAutocompleteCacheAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of the Payee Autocomplete Cache.
///
/// Each trie node holds a 26-slot array of children and, on terminal nodes,
/// the frequency count for the word that ends there.
///
/// - `record`: O(L) to walk/extend the trie, where L = payee name length.
/// - `suggest`: O(L) to reach the prefix node, then O(M) DFS over the
///   subtree (M = total characters of all payees sharing the prefix), plus
///   O(K log K) to sort the collected candidates, where K is the number of
///   matches. Returns at most `limit` results.
///
/// We compute the top-K lazily (DFS + sort) rather than caching per-node.
/// Trade-off:
///   - Pros: `record` stays O(L); memory stays minimal.
///   - Cons: `suggest` does more work per call.
///   For an autocomplete with thousands-of-payees scale and one DFS per
///   keystroke, this is the right default. If profiling showed `suggest` as
///   the hotspot, the next move is to cache a per-node top-K and refresh it
///   on `record`.
final class PayeeAutocompleteCacheAnswers {

    private final class Node {
        var children: [Node?] = Array(repeating: nil, count: 26)
        /// > 0 iff a payee name ends at this node.
        var frequency: Int = 0
    }

    private let root = Node()
    private static let a = UInt8(ascii: "a")

    init() {}

    func record(payeeName: String) {
        guard !payeeName.isEmpty else { return }
        var node = root
        for byte in payeeName.utf8 {
            let idx = Int(byte - Self.a)
            if let next = node.children[idx] {
                node = next
            } else {
                let newNode = Node()
                node.children[idx] = newNode
                node = newNode
            }
        }
        node.frequency += 1
    }

    func suggest(prefix: String, limit: Int) -> [String] {
        guard limit > 0 else { return [] }

        // 1) Walk to the prefix node. Bail early if the prefix isn't present.
        var node = root
        for byte in prefix.utf8 {
            let idx = Int(byte - Self.a)
            guard let next = node.children[idx] else { return [] }
            node = next
        }

        // 2) DFS the subtree, collecting (word, frequency) for every terminal.
        var matches: [(word: String, frequency: Int)] = []
        var buffer: [UInt8] = Array(prefix.utf8)
        collect(node: node, buffer: &buffer, into: &matches)

        // 3) Sort by frequency desc, then lexicographically asc; take `limit`.
        matches.sort { lhs, rhs in
            if lhs.frequency != rhs.frequency {
                return lhs.frequency > rhs.frequency
            }
            return lhs.word < rhs.word
        }
        return matches.prefix(limit).map { $0.word }
    }

    private func collect(
        node: Node,
        buffer: inout [UInt8],
        into matches: inout [(word: String, frequency: Int)]
    ) {
        if node.frequency > 0 {
            let word = String(decoding: buffer, as: UTF8.self)
            matches.append((word, node.frequency))
        }
        for idx in 0..<26 {
            guard let child = node.children[idx] else { continue }
            buffer.append(Self.a + UInt8(idx))
            collect(node: child, buffer: &buffer, into: &matches)
            buffer.removeLast()
        }
    }
}
