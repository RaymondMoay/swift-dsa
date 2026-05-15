//
//  SubarraySumEqualsKTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct SubarraySumEqualsKTests {

    @Test func canonicalExamples() async throws {
        #expect(SubarraySumEqualsK.perform([1, 1, 1], 2) == 2)
        #expect(SubarraySumEqualsK.perform([1, 2, 3], 3) == 2)
    }

    @Test func singleElementMatches() async throws {
        #expect(SubarraySumEqualsK.perform([5], 5) == 1)
        #expect(SubarraySumEqualsK.perform([5], 0) == 0)
    }

    @Test func includesZeros() async throws {
        // [1, -1, 0]: subarrays summing to 0 -> [1,-1], [0], [1,-1,0] = 3
        #expect(SubarraySumEqualsK.perform([1, -1, 0], 0) == 3)
    }

    @Test func allZerosWithKZero() async throws {
        // n*(n+1)/2 contiguous subarrays of all-zeros, all sum to 0.
        #expect(SubarraySumEqualsK.perform([0, 0, 0, 0], 0) == 10)
    }

    @Test func negativesPreventSlidingWindow() async throws {
        // 3 + 4 - 7 + 1 + 4 - 5 + 2 + (-6) + 3
        // Several subarrays sum to 0 — verifies non-sliding-window logic.
        #expect(SubarraySumEqualsK.perform([3, 4, 7, 2, -3, 1, 4, 2], 7) == 4)
    }

    @Test func noMatch() async throws {
        #expect(SubarraySumEqualsK.perform([1, 2, 3], 100) == 0)
    }

    @Test func entireArray() async throws {
        #expect(SubarraySumEqualsK.perform([1, 2, 3, 4], 10) == 1)
    }
}
