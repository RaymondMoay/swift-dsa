//
//  NumberOfIslandsTests.swift
//  SwiftDSA
//
//  Created by Ray on 2/7/25.
//

import Testing

@testable import SwiftDSA

struct NumberOfIslandsTests {

    @Test func assert() async throws {
        let map = [
            [0, 1, 0, 1, 0],
            [0, 0, 0, 1, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0],
        ]

        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 2)
        #expect(NumberOfIslands.perform(map: map, start: (x: 4, y: 0)) == 2)
        #expect(NumberOfIslands.perform(map: map, start: (x: 3, y: 0)) == 2)
    }

    // No 1s anywhere — count must be 0.
    @Test func emptyMapHasNoIslands() async throws {
        let map = [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 0)
    }

    // A single 1x1 grid in each variant.
    @Test func singleCellMap() async throws {
        #expect(NumberOfIslands.perform(map: [[1]], start: (x: 0, y: 0)) == 1)
        #expect(NumberOfIslands.perform(map: [[0]], start: (x: 0, y: 0)) == 0)
    }

    // One isolated cell in the middle of zeros.
    @Test func singleIsolatedCellIsland() async throws {
        let map = [
            [0, 0, 0],
            [0, 1, 0],
            [0, 0, 0],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // The entire map is filled with 1s — should collapse into one island.
    @Test func entireMapIsOneIsland() async throws {
        let map = [
            [1, 1, 1],
            [1, 1, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // Diagonal-only adjacency does NOT connect cells (only 4-directional).
    // Checkerboard of 1s should produce 5 separate islands.
    @Test func diagonalAdjacencyDoesNotConnect() async throws {
        let map = [
            [1, 0, 1],
            [0, 1, 0],
            [1, 0, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 5)
    }

    // Many separate single-cell islands across a wider grid.
    @Test func multipleSeparateIslands() async throws {
        let map = [
            [1, 0, 1, 0, 1],
            [0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 6)
    }

    // Single horizontal strip — all 1s in one row.
    @Test func horizontalStripIsOneIsland() async throws {
        let map = [
            [1, 1, 1, 1, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // Single vertical strip — all 1s in one column.
    @Test func verticalStripIsOneIsland() async throws {
        let map = [
            [1],
            [1],
            [1],
            [1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // U-shape: two vertical arms joined by a bottom row. Verifies the
    // flood-fill follows the connected path rather than treating the
    // arms as separate islands.
    @Test func uShapedIsland() async throws {
        let map = [
            [1, 0, 1],
            [1, 0, 1],
            [1, 1, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // Ring of 1s around a 0 hole. The hole is surrounded but is still
    // its own (zero-)region — the ring counts as one island.
    @Test func ringIslandWithHole() async throws {
        let map = [
            [1, 1, 1],
            [1, 0, 1],
            [1, 1, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 1)
    }

    // Non-square: very wide single-row map with alternating cells.
    @Test func wideNonSquareMap() async throws {
        let map = [
            [1, 0, 1, 0, 1, 0, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 4)
    }

    // Non-square: very tall single-column map.
    @Test func tallNonSquareMap() async throws {
        let map = [
            [1],
            [0],
            [1],
            [0],
            [1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 3)
    }

    // Islands at the corners and edges — verifies bounds handling.
    @Test func cornerAndEdgeIslands() async throws {
        let map = [
            [1, 0, 0, 1],
            [0, 0, 0, 0],
            [1, 0, 0, 1],
        ]
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 4)
    }

    // The same map should produce the same count regardless of where
    // exploration starts — including starting on a 0 cell or a 1 cell.
    @Test func answerIsIndependentOfStartPosition() async throws {
        let map = [
            [1, 0, 1, 0],
            [0, 0, 0, 1],
            [1, 1, 0, 0],
        ]
        // Islands: (0,0); (2,0); (3,1); (0,2)+(1,2)  → 4 total
        let expected = 4

        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == expected) // corner, on 1
        #expect(NumberOfIslands.perform(map: map, start: (x: 3, y: 0)) == expected) // corner, on 0
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 2)) == expected) // corner, on 1
        #expect(NumberOfIslands.perform(map: map, start: (x: 2, y: 1)) == expected) // middle, on 0
        #expect(NumberOfIslands.perform(map: map, start: (x: 3, y: 1)) == expected) // edge, on 1
    }

    // Larger graph with islands of varying shapes and sizes.
    @Test func mixedShapesAndSizes() async throws {
        let map = [
            [1, 1, 0, 0, 1, 0, 1, 1],
            [1, 0, 0, 1, 1, 0, 0, 1],
            [0, 0, 1, 1, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 1, 1, 1],
            [1, 1, 0, 1, 0, 1, 0, 1],
        ]
        // Islands:
        //   A: (0,0)(1,0)(0,1)                                — top-left L
        //   B: (4,0)(3,1)(4,1)(2,2)(3,2)                      — middle blob
        //   C: (6,0)(7,0)(7,1)                                — top-right L
        //   D: (0,3)(0,4)(1,4)                                — bottom-left L
        //   E: (3,4)                                          — single
        //   F: (5,3)(6,3)(7,3)(5,4)(7,4)                      — right-side cluster
        //                                                       (5,4)-(5,3) connected vertically;
        //                                                       (7,4)-(7,3) connected vertically
        // Total: 6
        #expect(NumberOfIslands.perform(map: map, start: (x: 0, y: 0)) == 6)
    }
}
