//
//  CoinChangeWaysTests.swift
//  SwiftDSA
//
//  Created by Ray on 14/5/26.
//

import Testing

@testable import SwiftDSA

struct CoinChangeWaysTests {

    @Test func topDown() async throws {
        #expect(CoinChangeWays.performTopDown([1, 2, 5], 5) == 4)     // 5; 2+2+1; 2+1+1+1; 1*5
        #expect(CoinChangeWays.performTopDown([2], 3) == 0)           // unreachable
        #expect(CoinChangeWays.performTopDown([1, 4, 8], 7) == 2)     // 1+1+1+4; 1*7
        #expect(CoinChangeWays.performTopDown([10], 10) == 1)
        #expect(CoinChangeWays.performTopDown([1], 0) == 1)           // base: empty selection
        #expect(CoinChangeWays.performTopDown([], 0) == 1)            // edge: no coins, amount 0
        #expect(CoinChangeWays.performTopDown([], 5) == 0)            // edge: no coins, amount > 0
        #expect(CoinChangeWays.performTopDown([1, 2, 3], 4) == 4)     // 1+1+1+1; 1+1+2; 2+2; 1+3
        #expect(CoinChangeWays.performTopDown([3, 5, 7, 8, 9, 10, 11], 500) == 35502874)
    }

    @Test func bottomUp() async throws {
        #expect(CoinChangeWays.performBottomUp([1, 2, 5], 5) == 4)
        #expect(CoinChangeWays.performBottomUp([2], 3) == 0)
        #expect(CoinChangeWays.performBottomUp([1, 4, 8], 7) == 2)
        #expect(CoinChangeWays.performBottomUp([10], 10) == 1)
        #expect(CoinChangeWays.performBottomUp([1], 0) == 1)
        #expect(CoinChangeWays.performBottomUp([], 0) == 1)
        #expect(CoinChangeWays.performBottomUp([], 5) == 0)
        #expect(CoinChangeWays.performBottomUp([1, 2, 3], 4) == 4)
        #expect(CoinChangeWays.performBottomUp([3, 5, 7, 8, 9, 10, 11], 500) == 35502874)
    }

    @Test func answerTopDown() async throws {
        #expect(CoinChangeWaysAnswer.performTopDown([1, 2, 5], 5) == 4)
        #expect(CoinChangeWaysAnswer.performTopDown([2], 3) == 0)
        #expect(CoinChangeWaysAnswer.performTopDown([1, 4, 8], 7) == 2)
        #expect(CoinChangeWaysAnswer.performTopDown([10], 10) == 1)
        #expect(CoinChangeWaysAnswer.performTopDown([1], 0) == 1)
        #expect(CoinChangeWaysAnswer.performTopDown([], 0) == 1)
        #expect(CoinChangeWaysAnswer.performTopDown([], 5) == 0)
        #expect(CoinChangeWaysAnswer.performTopDown([1, 2, 3], 4) == 4)
        #expect(CoinChangeWaysAnswer.performTopDown([3, 5, 7, 8, 9, 10, 11], 500) == 35502874)
    }

    @Test func answerBottomUp() async throws {
        #expect(CoinChangeWaysAnswer.performBottomUp([1, 2, 5], 5) == 4)
        #expect(CoinChangeWaysAnswer.performBottomUp([2], 3) == 0)
        #expect(CoinChangeWaysAnswer.performBottomUp([1, 4, 8], 7) == 2)
        #expect(CoinChangeWaysAnswer.performBottomUp([10], 10) == 1)
        #expect(CoinChangeWaysAnswer.performBottomUp([1], 0) == 1)
        #expect(CoinChangeWaysAnswer.performBottomUp([], 0) == 1)
        #expect(CoinChangeWaysAnswer.performBottomUp([], 5) == 0)
        #expect(CoinChangeWaysAnswer.performBottomUp([1, 2, 3], 4) == 4)
        #expect(CoinChangeWaysAnswer.performBottomUp([3, 5, 7, 8, 9, 10, 11], 500) == 35502874)
    }
}
