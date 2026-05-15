//
//  SearchSuggestionsSystemAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 1268 — Search Suggestions System.
///
/// Strategy: sort `products` lexicographically, then insert into a trie. At
/// each node along the way, keep an array of up to 3 product strings — these
/// are guaranteed to be the lexicographically smallest words passing through
/// that node because we inserted in sorted order.
///
/// Build:  O(N * L)        — N = #products, L = max product length.
/// Query:  O(W)            — W = searchWord.count; constant work per char.
/// Space:  O(N * L)        — trie nodes plus the cached suggestions.
struct SearchSuggestionsSystemAnswer {

    private final class Node {
        var children: [Node?] = Array(repeating: nil, count: 26)
        // Up to 3 lexicographically smallest words passing through this node.
        var suggestions: [String] = []
    }

    private static let a = UInt8(ascii: "a")

    static func perform(_ products: [String], _ searchWord: String) -> [[String]] {
        let sorted = products.sorted()
        let root = Node()

        for product in sorted {
            var node = root
            for byte in product.utf8 {
                let idx = Int(byte - a)
                let next: Node
                if let existing = node.children[idx] {
                    next = existing
                } else {
                    let newNode = Node()
                    node.children[idx] = newNode
                    next = newNode
                }
                if next.suggestions.count < 3 {
                    next.suggestions.append(product)
                }
                node = next
            }
        }

        var result: [[String]] = []
        result.reserveCapacity(searchWord.count)

        var node: Node? = root
        for byte in searchWord.utf8 {
            if let current = node {
                let idx = Int(byte - a)
                node = current.children[idx]
            }
            result.append(node?.suggestions ?? [])
        }
        return result
    }
}
