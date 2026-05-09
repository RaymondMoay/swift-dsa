//
//  ClimbingStairsTests.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

import Testing

@testable import SwiftDSA

struct ClimbingStairsTests {

    @Test func topDown() async throws {
        #expect(ClimbingStairs.performTopDown(1) == 1)
        #expect(ClimbingStairs.performTopDown(2) == 2)
        #expect(ClimbingStairs.performTopDown(3) == 3)
        #expect(ClimbingStairs.performTopDown(4) == 5)
        #expect(ClimbingStairs.performTopDown(5) == 8)
        #expect(ClimbingStairs.performTopDown(10) == 89)
        #expect(ClimbingStairs.performTopDown(45) == 1_836_311_903)
    }

    @Test func bottomUp() async throws {
        #expect(ClimbingStairs.performBottomUp(1) == 1)
        #expect(ClimbingStairs.performBottomUp(2) == 2)
        #expect(ClimbingStairs.performBottomUp(3) == 3)
        #expect(ClimbingStairs.performBottomUp(4) == 5)
        #expect(ClimbingStairs.performBottomUp(5) == 8)
        #expect(ClimbingStairs.performBottomUp(10) == 89)
        #expect(ClimbingStairs.performBottomUp(45) == 1_836_311_903)
    }

    @Test func optimized() async throws {
        #expect(ClimbingStairs.performOptimized(1) == 1)
        #expect(ClimbingStairs.performOptimized(2) == 2)
        #expect(ClimbingStairs.performOptimized(3) == 3)
        #expect(ClimbingStairs.performOptimized(4) == 5)
        #expect(ClimbingStairs.performOptimized(5) == 8)
        #expect(ClimbingStairs.performOptimized(10) == 89)
        #expect(ClimbingStairs.performOptimized(45) == 1_836_311_903)
    }
}
