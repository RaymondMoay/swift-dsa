//
//  MinimumSizeSubarraySumTests.swift
//  SwiftDSA
//
//  Created by Ray on 5/13/26.
//

import Testing

@testable import SwiftDSA

struct MinimumSizeSubarraySumTests {

    @Test func canonicalExample() async throws {
        // [4, 3] sums to 7, length 2.
        #expect(MinimumSizeSubarraySum.perform(7, [2, 3, 1, 2, 4, 3]) == 2)
    }

    @Test func singleElementSatisfiesTarget() async throws {
        // 4 alone meets the target -> length 1.
        #expect(MinimumSizeSubarraySum.perform(4, [1, 4, 4]) == 1)
    }

    @Test func noValidSubarrayReturnsZero() async throws {
        // Total sum is 4, never reaches 11.
        #expect(MinimumSizeSubarraySum.perform(11, [1, 1, 1, 1]) == 0)
    }

    @Test func entireArrayRequired() async throws {
        // Only the full array reaches 15.
        #expect(MinimumSizeSubarraySum.perform(15, [1, 2, 3, 4, 5]) == 5)
    }

    @Test func exactMatchAtEnd() async throws {
        // The final window [4, 3] is valid; shorter [7]-style windows don't exist.
        #expect(MinimumSizeSubarraySum.perform(7, [1, 1, 1, 1, 4, 3]) == 2)
    }

    @Test func singleElementArray() async throws {
        #expect(MinimumSizeSubarraySum.perform(5, [5]) == 1)
        #expect(MinimumSizeSubarraySum.perform(6, [5]) == 0)
    }

    @Test func multipleValidWindowsPicksShortest() async throws {
        // [10] alone is valid -> length 1 beats any longer window.
        #expect(MinimumSizeSubarraySum.perform(8, [1, 2, 3, 10, 1, 1]) == 1)
    }

    @Test func shrinkLeftFindsShorterWindow() async throws {
        // Expanding to [1,2,3,4,5] gives sum 15; shrinking left to [3,4,5]
        // still sums to 12 >= 11, length 3.
        #expect(MinimumSizeSubarraySum.perform(11, [1, 2, 3, 4, 5]) == 3)
    }
}
