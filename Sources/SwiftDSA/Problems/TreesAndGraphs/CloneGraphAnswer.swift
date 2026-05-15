//
//  CloneGraphAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct CloneGraphAnswer {

    /// DFS clone with an identity-keyed memo.
    ///
    /// For each original node we create exactly one clone, then recursively
    /// clone its neighbours. The memo (`original -> clone`) ensures we visit
    /// each node only once and that cycles terminate.
    ///
    /// Time:  O(V + E) — every node and edge is touched once.
    /// Space: O(V) — memo + recursion stack.
    static func perform(_ node: GraphNode?) -> GraphNode? {
        guard let node else { return nil }

        var memo: [ObjectIdentifier: GraphNode] = [:]

        func clone(_ original: GraphNode) -> GraphNode {
            let key = ObjectIdentifier(original)
            if let existing = memo[key] { return existing }

            let copy = GraphNode(original.value)
            memo[key] = copy

            // Clone neighbours after inserting `copy` into the memo so cycles
            // resolve to the in-progress clone instead of recursing forever.
            copy.neighbours = original.neighbours.map { clone($0) }
            return copy
        }

        return clone(node)
    }
}
