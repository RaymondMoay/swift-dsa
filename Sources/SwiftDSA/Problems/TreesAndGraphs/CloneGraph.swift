//
//  CloneGraph.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 133 — Clone Graph
//
//  Given a reference of a node in a connected, undirected graph, return a
//  deep copy (clone) of the graph. Each node has a unique value and a list
//  of neighbours.
//
//  Example:
//    Input graph (adjacency list, 1-indexed):
//      1: [2, 4]
//      2: [1, 3]
//      3: [2, 4]
//      4: [1, 3]
//
//    Return a node with the same `value` as the input node, but in a
//    completely independent graph (no shared `GraphNode` references).
//
//    nil -> nil
//
//  Constraints:
//    The number of nodes is in [0, 100]. Values are unique. The graph may
//    contain self-loops and is connected.
//
//  Hints:
//    - Maintain a map from `originalNode -> clonedNode` to avoid revisiting
//      and to break cycles.
//    - DFS (recursive) is shortest. BFS works too — clone the start, then
//      walk the queue and stitch up neighbours.
//    - Use object identity (`ObjectIdentifier`) as the map key, since
//      `GraphNode` is a reference type.
//
//  Domain framing (from study guide):
//    Models deep-copying payment state — e.g. snapshotting the in-memory
//    transaction graph (payer, payee, intermediate routing nodes) before
//    mutating it for retry, without aliasing the original.
//
//  Target: O(V + E) time, O(V) space.

final class GraphNode {
    let value: Int
    var neighbours: [GraphNode]

    init(_ value: Int, _ neighbours: [GraphNode] = []) {
        self.value = value
        self.neighbours = neighbours
    }
}

struct CloneGraph {

    static func perform(_ node: GraphNode?) -> GraphNode? {
        
        // traverse a graph's relationship. Deep-copy means DFS, because i need to preserve shape.
        
        // trick: I need to "deep-copy", means i need to create new instances of it, rather than references.
        
        // I need to be able to say "I have copied this node before", and not re-traverse it again.
        
        /// There are 100 nodes, and we need a way to say we have copied them...
        var copied: [ObjectIdentifier: GraphNode] = [:]
        
        // We are missing cycles.
        
        func copy(curr: GraphNode?) -> GraphNode? {
            // BASE CASE
            // 1. is this traversable?
            guard let curr else { return nil }
            
            // 2. have i seen and copied this before?
            /// Because of this, we are missing out on cycles for the neighbour!
            if let existing = copied[ObjectIdentifier(curr)] {
                return existing
            }
            
            // Recurse
            
            // pre
            let newNode = GraphNode(curr.value)
            copied[ObjectIdentifier(curr)] = newNode
            
            // recurse
            var copiedNeighbours: [GraphNode] = []
            for neighbour in curr.neighbours {
                guard let copiedNeighbour = copy(curr: neighbour) else { continue }
                copiedNeighbours.append(copiedNeighbour)
            }
            
            // post
            newNode.neighbours = copiedNeighbours
            return newNode
        }
        
        return copy(curr: node)
    }
}
