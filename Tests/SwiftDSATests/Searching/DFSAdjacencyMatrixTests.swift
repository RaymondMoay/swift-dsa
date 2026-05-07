//
//  DFSAdjacencyMatrixTests.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

import Testing

@testable import SwiftDSA

struct DFSAdjacencyMatrixTests {

    @Test func assert() async throws {
        // Same graph used by BFSAdjacencyMatrixTests so results can be cross-checked.
        //
        //   0 → 1 (3), 2 (1)
        //   1 → 0 (5)
        //   2 → 3 (4)
        //   3 → 1 (1), 4 (2)
        //   4 → (none)
        let graph: [[Int]] = [
            [0,3,1,0,0], // 0
            [5,0,0,0,0], // 1
            [0,0,0,4,0], // 2
            [0,1,0,0,2], // 3
            [0,0,0,0,0], // 4
        ]

        // For this graph there's only one valid path between any source/needle pair,
        // so DFS and BFS produce identical results.
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 4) == [0, 2, 3, 4])
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 1, needle: 4) == [1, 0, 2, 3, 4])
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 3, needle: 4) == [3, 4])
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 2, needle: 4) == [2, 3, 4])

        // source == needle: DFS naturally produces [source] (matches DFSAdjacencyList).
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 4, needle: 4) == [4])

        // Unreachable: vertex 4 has no outgoing edges.
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 4, needle: 3) == [])
    }

    // DFS must follow the depth-first ordering. Given a graph where vertex 0
    // has neighbors [1, 2] in column order, and only vertex 1 leads to the
    // needle, DFS should explore 1 first, find the needle there, and never
    // visit 2. The resulting path must include 1, not 2.
    @Test func depthFirstOrderingFollowsColumnOrder() async throws {
        //   0 → 1, 2
        //   1 → 3 (the needle)
        //   2 → 3
        //   3 → (none)
        let graph: [[Int]] = [
            [0,1,1,0], // 0
            [0,0,0,1], // 1
            [0,0,0,1], // 2
            [0,0,0,0], // 3
        ]

        // 1 comes before 2 in column order, so DFS hits the needle via 1.
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 3) == [0, 1, 3])
    }

    // Backtracking must work: explore a dead-end branch, unwind, then try
    // the alternate branch.
    @Test func backtracksOutOfDeadEnd() async throws {
        //   0 → 1, 3
        //   1 → 2 (dead-end branch — 2 has no outgoing edges)
        //   2 → (none)
        //   3 → 4 (the needle)
        //   4 → (none)
        let graph: [[Int]] = [
            [0,1,0,1,0], // 0
            [0,0,1,0,0], // 1
            [0,0,0,0,0], // 2 — dead end
            [0,0,0,0,1], // 3
            [0,0,0,0,0], // 4
        ]

        // DFS should explore 0 → 1 → 2 (dead end), backtrack to 0, then 0 → 3 → 4.
        // Crucially, the final path must NOT contain 1 or 2 (they were popped on backtrack).
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 4) == [0, 3, 4])
    }

    // Cycles must not cause infinite recursion — `seen` should prevent revisits.
    @Test func handlesCycles() async throws {
        //   0 → 1
        //   1 → 0, 2  (back-edge to 0)
        //   2 → 1, 3  (back-edge to 1)
        //   3 → 2     (back-edge to 2)
        let graph: [[Int]] = [
            [0,1,0,0], // 0
            [1,0,1,0], // 1
            [0,1,0,1], // 2
            [0,0,1,0], // 3
        ]

        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 3) == [0, 1, 2, 3])
    }

    // Disconnected component — needle is unreachable from source.
    @Test func disconnectedGraph() async throws {
        //   0 ↔ 1
        //   2 ↔ 3
        let graph: [[Int]] = [
            [0,1,0,0], // 0
            [1,0,0,0], // 1
            [0,0,0,1], // 2
            [0,0,1,0], // 3
        ]

        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 3) == [])
        #expect(DFSAdjacencyMatrix.perform(graph: graph, source: 2, needle: 3) == [2, 3])
    }
}
