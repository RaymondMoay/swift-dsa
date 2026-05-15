//
//  ContiguousArrayEqualZerosOnesTests.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//

import Testing

@testable import SwiftDSA

struct ContiguousArrayEqualZerosOnesTests {

    @Test func twoElementBalanced() async throws {
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 1]) == 2)
        #expect(ContiguousArrayEqualZerosOnes.perform([1, 0]) == 2)
    }

    @Test func threeElementsBestIsTwo() async throws {
        // Any two adjacent of [0,1,0] gives one 0 + one 1 -> length 2.
        // No length-3 subarray can be balanced (odd length).
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 1, 0]) == 2)
    }

    @Test func allSameValueHasNoBalancedSubarray() async throws {
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 0, 0, 0]) == 0)
        #expect(ContiguousArrayEqualZerosOnes.perform([1, 1, 1, 1]) == 0)
    }

    @Test func singleElementHasNoBalancedSubarray() async throws {
        #expect(ContiguousArrayEqualZerosOnes.perform([0]) == 0)
        #expect(ContiguousArrayEqualZerosOnes.perform([1]) == 0)
    }

    @Test func entireArrayBalanced() async throws {
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 0, 1, 1]) == 4)
        #expect(ContiguousArrayEqualZerosOnes.perform([1, 1, 0, 0]) == 4)
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 1, 1, 0]) == 4)
    }

    @Test func balancedInterior() async throws {
        // [0, 1, 1, 0, 1, 1] -> best balanced is [0,1,1,0] at indices 0..3, length 4.
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 1, 1, 0, 1, 1]) == 4)
    }

    @Test func longerCase() async throws {
        // [0, 0, 1, 0, 0, 0, 1, 1]: prefix sums (0->-1, 1->+1):
        //   -1, -2, -1, -2, -3, -4, -3, -2
        // Repeated values:
        //   -1 at j=0 and j=2 (gap 2)
        //   -2 at j=1, j=3, j=7 (best gap 7-1=6)
        //   -3 at j=4, j=6 (gap 2)
        // Longest = 6.
        #expect(ContiguousArrayEqualZerosOnes.perform([0, 0, 1, 0, 0, 0, 1, 1]) == 6)
    }

    @Test func emptyArray() async throws {
        #expect(ContiguousArrayEqualZerosOnes.perform([]) == 0)
    }
}
