//
//  LongestSubarrayDivisibleByKTests.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//

import Testing

@testable import SwiftDSA

struct LongestSubarrayDivisibleByKTests {

    @Test func canonicalPositiveCase() async throws {
        // [7, 6, 1, 4] sums to 18, divisible by 3, length 4.
        #expect(LongestSubarrayDivisibleByK.perform([2, 7, 6, 1, 4, 5], 3) == 4)
    }

    @Test func wholeArrayIsAnswer() async throws {
        // 4+5+0+(-2)+(-3)+1 = 5, divisible by 5, length 6.
        #expect(LongestSubarrayDivisibleByK.perform([4, 5, 0, -2, -3, 1], 5) == 6)
    }

    @Test func noValidSubarray() async throws {
        // Each prefix sum mod 5: 1, 3, 2, 4. None repeat, none are 0 after the seed
        // beyond the initial. Wait — with the seed {0:-1}, only an actual divisible
        // prefix would trigger. Here no subarray sums to a multiple of 5.
        #expect(LongestSubarrayDivisibleByK.perform([1, 2, 4, 2], 5) == 0)
    }

    @Test func singleElementDivisible() async throws {
        // [6] is divisible by 3 -> length 1.
        #expect(LongestSubarrayDivisibleByK.perform([6], 3) == 1)
    }

    @Test func singleElementNotDivisible() async throws {
        #expect(LongestSubarrayDivisibleByK.perform([7], 3) == 0)
    }

    @Test func handlesNegatives() async throws {
        // Prefix sums: -2, 1, -3, 1. Mods k=4: 2, 1, 1, 1.
        // Indices of mod=1: j=1 (first), then j=2 (gap=1), j=3 (gap=2).
        // Best length = 2.
        #expect(LongestSubarrayDivisibleByK.perform([-2, 3, -4, 4], 4) == 2)
    }

    @Test func allZeros() async throws {
        // Every prefix sum is 0; longest subarray with sum divisible by k is
        // the entire array.
        #expect(LongestSubarrayDivisibleByK.perform([0, 0, 0, 0], 3) == 4)
    }

    @Test func kEqualsOneEverythingDivisible() async throws {
        // Every integer is divisible by 1.
        #expect(LongestSubarrayDivisibleByK.perform([3, 1, 4, 1, 5, 9], 1) == 6)
    }
}
