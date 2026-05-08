//
//  DjikstraTests.swift
//  SwiftDSA
//
//  Created by Ray on 1/7/25.
//

import Testing

@testable import SwiftDSA

struct DijkstraTests {

    // Original baseline graph — kept as a regression check.
    //
    //   0 → 1 (1), 2 (5)
    //   1 → 2 (7), 3 (6)
    //   2 → 4 (1)
    //   3 → 2 (1)
    //   4 → (none)
    @Test func baseline() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1), .init(to: 2, weight: 5)], // 0
            [.init(to: 2, weight: 7), .init(to: 3, weight: 6)], // 1
            [.init(to: 4, weight: 1)],                          // 2
            [.init(to: 2, weight: 1)],                          // 3
            []                                                  // 4
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 4) == [0, 2, 4])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 1, 3])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 2) == [0, 2])
    }

    // Same baseline graph from a non-zero source.
    //
    // From 1, costs to 4:
    //   1 → 2 → 4         = 7 + 1 = 8
    //   1 → 3 → 2 → 4     = 6 + 1 + 1 = 8  (tie)
    // Strict-less-than update keeps the first-discovered path: [1, 2, 4].
    @Test func fromNonZeroSourceWithTie() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1), .init(to: 2, weight: 5)],
            [.init(to: 2, weight: 7), .init(to: 3, weight: 6)],
            [.init(to: 4, weight: 1)],
            [.init(to: 2, weight: 1)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 1, sink: 4) == [1, 2, 4])
        #expect(Dijkstra.perform(graph: graph, source: 3, sink: 4) == [3, 2, 4])
    }

    // Source equals sink — trivial path of length 1 (just the node).
    @Test func sourceEqualsSink() async throws {
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 0) == [0])
        #expect(Dijkstra.perform(graph: graph, source: 1, sink: 1) == [1])
    }

    // Single-vertex graph — only one node, source == sink is the only valid query.
    @Test func singleVertexGraph() async throws {
        let graph: WeightedAdjacencyList = [[]]
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 0) == [0])
    }

    // Linear chain — every step must be taken in order.
    @Test func linearChain() async throws {
        //   0 → 1 (2) → 2 (3) → 3 (4)
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 2)],
            [.init(to: 2, weight: 3)],
            [.init(to: 3, weight: 4)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 1, 2, 3])
        #expect(Dijkstra.perform(graph: graph, source: 1, sink: 3) == [1, 2, 3])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 1) == [0, 1])
    }

    // Diamond — two disjoint paths to the same sink. Algorithm must
    // pick the cheaper one based on total path weight.
    @Test func diamondPicksCheaperPath() async throws {
        //   0 → 1 (1)  → 3 (10)   total 11
        //   0 → 2 (5)  → 3 (5)    total 10  ← cheaper
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1), .init(to: 2, weight: 5)],
            [.init(to: 3, weight: 10)],
            [.init(to: 3, weight: 5)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 2, 3])
    }

    // The headline correctness test: a high-weight direct edge must lose
    // to a cheaper multi-hop path. A greedy "first edge wins" algorithm
    // would fail this; Dijkstra must not.
    @Test func cheaperViaIntermediateBeatsDirectEdge() async throws {
        //   0 → 2 (100)             direct, expensive
        //   0 → 1 (1) → 2 (1)       2 hops, total 2
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 1), .init(to: 2, weight: 100)],
            [.init(to: 2, weight: 1)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 2) == [0, 1, 2])
    }

    // Tests that Dijkstra updates `prev` correctly when a shorter path
    // is discovered AFTER an initial longer path. Vertex 1 is first
    // reached via 0 → 1 with cost 5, then via 0 → 2 → 1 with cost 2,
    // and the path to 3 must reflect the shorter route.
    @Test func relaxesToShorterPathAfterFirstDiscovery() async throws {
        //   0 → 1 (5)
        //   0 → 2 (1)
        //   2 → 1 (1)        gives 0 → 2 → 1 = 2 (better than 5)
        //   1 → 3 (2)
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 5), .init(to: 2, weight: 1)],
            [.init(to: 3, weight: 2)],
            [.init(to: 1, weight: 1)],
            []
        ]

        // Best 0 → 3:  0 → 2 → 1 → 3  total = 1 + 1 + 2 = 4
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 2, 1, 3])
    }

    // Undirected graph (every edge listed in both directions). Tests
    // that the algorithm doesn't accidentally rely on directionality
    // and finds the true shortest path via an intermediate that
    // looked initially expensive.
    @Test func undirectedGraphFindsShortestViaTriangle() async throws {
        //   0 ↔ 1 (5)
        //   0 ↔ 2 (1)
        //   1 ↔ 2 (1)
        //   1 ↔ 3 (2)
        //   2 ↔ 3 (4)
        //
        // Best 0 → 3:  0 → 2 → 1 → 3  total = 1 + 1 + 2 = 4
        // Worse: 0 → 2 → 3 = 5; 0 → 1 → 3 = 7.
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 5), .init(to: 2, weight: 1)],                          // 0
            [.init(to: 0, weight: 5), .init(to: 2, weight: 1), .init(to: 3, weight: 2)], // 1
            [.init(to: 0, weight: 1), .init(to: 1, weight: 1), .init(to: 3, weight: 4)], // 2
            [.init(to: 1, weight: 2), .init(to: 2, weight: 4)]                           // 3
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 2, 1, 3])
        #expect(Dijkstra.perform(graph: graph, source: 3, sink: 0) == [3, 1, 2, 0])
    }

    // Larger graph with multiple competing routes. Tests that the
    // final `dist` and `prev` survive several rounds of relaxation.
    @Test func largerGraphMultipleRelaxations() async throws {
        //   0 → 1 (4), 2 (1)
        //   1 → 3 (1)
        //   2 → 1 (2), 3 (5)
        //   3 → 4 (3)
        //   4 → (none)
        //
        // 0 → 4 candidates:
        //   0 → 1 → 3 → 4              = 4 + 1 + 3 = 8
        //   0 → 2 → 1 → 3 → 4          = 1 + 2 + 1 + 3 = 7  ← best
        //   0 → 2 → 3 → 4              = 1 + 5 + 3 = 9
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 4), .init(to: 2, weight: 1)],
            [.init(to: 3, weight: 1)],
            [.init(to: 1, weight: 2), .init(to: 3, weight: 5)],
            [.init(to: 4, weight: 3)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 4) == [0, 2, 1, 3, 4])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0, 2, 1, 3])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 1) == [0, 2, 1])
    }

    // Zero-weight edges must still be valid. Path along zeros is the
    // shortest possible (cost 0).
    @Test func zeroWeightEdgesAreHandled() async throws {
        //   0 → 1 (0) → 2 (0)        total 0  ← best
        //   0 → 2 (10)                total 10
        let graph: WeightedAdjacencyList = [
            [.init(to: 1, weight: 0), .init(to: 2, weight: 10)],
            [.init(to: 2, weight: 0)],
            []
        ]

        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 2) == [0, 1, 2])
    }
}
