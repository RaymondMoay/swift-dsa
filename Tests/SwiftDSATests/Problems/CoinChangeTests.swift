//
//  CoinChangeTests.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

import Testing

@testable import SwiftDSA

struct CoinChangeTests {

    @Test func topDown() async throws {
        #expect(CoinChange.performTopDown([1, 2, 5], 11) == 3)   // 5 + 5 + 1
        #expect(CoinChange.performTopDown([2], 3) == -1)         // unreachable
        #expect(CoinChange.performTopDown([1], 0) == 0)          // base
        #expect(CoinChange.performTopDown([1], 1) == 1)
        #expect(CoinChange.performTopDown([1], 2) == 2)
        #expect(CoinChange.performTopDown([2, 5, 10, 1], 27) == 4) // 10 + 10 + 5 + 2
        #expect(CoinChange.performTopDown([186, 419, 83, 408], 6249) == 20)
    }

    @Test func bottomUp() async throws {
        #expect(CoinChange.performBottomUp([1, 2, 5], 11) == 3)
        #expect(CoinChange.performBottomUp([2], 3) == -1)
        #expect(CoinChange.performBottomUp([1], 0) == 0)
        #expect(CoinChange.performBottomUp([1], 1) == 1)
        #expect(CoinChange.performBottomUp([1], 2) == 2)
        #expect(CoinChange.performBottomUp([2, 5, 10, 1], 27) == 4)
        #expect(CoinChange.performBottomUp([186, 419, 83, 408], 6249) == 20)
    }
}
