//
//  BFSAdjacencyListTests.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

import Testing

@testable import SwiftDSA

struct BFSAdjacencyListTests {

    @Test func assert() async throws {
        // Same graph as BFSAdjacencyMatrixTests, in adjacency-list form.
        // BFS shortest paths must match regardless of representation.
        //
        //   0 → 1 (3), 2 (1)
        //   1 → 0 (5)
        //   2 → 3 (4)
        //   3 → 1 (1), 4 (2)
        //   4 → (none)
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 3), .init(to: 2, weight: 1)], // 0
            [.init(to: 0, weight: 5)],                          // 1
            [.init(to: 3, weight: 4)],                          // 2
            [.init(to: 1, weight: 1), .init(to: 4, weight: 2)], // 3
            []                                                  // 4
        ]

        #expect(BFSAdjacencyList.perform(graph: graph, source: 0, needle: 4) == [0, 2, 3, 4])
        #expect(BFSAdjacencyList.perform(graph: graph, source: 1, needle: 4) == [1, 0, 2, 3, 4])
        #expect(BFSAdjacencyList.perform(graph: graph, source: 3, needle: 4) == [3, 4])
        #expect(BFSAdjacencyList.perform(graph: graph, source: 2, needle: 4) == [2, 3, 4])

        // Source equals needle — no traversal needed; should return empty path.
        #expect(BFSAdjacencyList.perform(graph: graph, source: 4, needle: 4) == [])

        // Needle unreachable from source (4 has no outgoing edges).
        #expect(BFSAdjacencyList.perform(graph: graph, source: 4, needle: 3) == [])
    }

    // BFS must return the path with the fewest edges, even if a longer
    // path exists. Here 0→3 directly (1 edge) should beat 0→1→2→3 (3 edges).
    @Test func picksShortestByEdgeCount() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1), .init(to: 3, weight: 99)], // 0
            [.init(to: 2, weight: 1)],                           // 1
            [.init(to: 3, weight: 1)],                           // 2
            []                                                   // 3
        ]

        #expect(BFSAdjacencyList.perform(graph: graph, source: 0, needle: 3) == [0, 3])
    }

    // Disconnected components — needle is in a separate component.
    @Test func disconnectedGraph() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1)], // 0
            [.init(to: 0, weight: 1)], // 1
            [.init(to: 3, weight: 1)], // 2
            [.init(to: 2, weight: 1)]  // 3
        ]

        #expect(BFSAdjacencyList.perform(graph: graph, source: 0, needle: 3) == [])
        #expect(BFSAdjacencyList.perform(graph: graph, source: 2, needle: 3) == [2, 3])
    }

    // A cycle must not cause infinite traversal — `seen` should prevent
    // revisits. The path from 0 to 3 is 0 → 1 → 2 → 3.
    @Test func handlesCycles() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1)],                          // 0
            [.init(to: 2, weight: 1), .init(to: 0, weight: 1)], // 1 (back edge to 0)
            [.init(to: 3, weight: 1), .init(to: 1, weight: 1)], // 2 (back edge to 1)
            [.init(to: 2, weight: 1)]                           // 3 (back edge to 2)
        ]

        #expect(BFSAdjacencyList.perform(graph: graph, source: 0, needle: 3) == [0, 1, 2, 3])
    }
}
