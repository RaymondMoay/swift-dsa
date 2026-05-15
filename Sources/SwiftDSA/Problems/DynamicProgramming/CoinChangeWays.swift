//
//  CoinChangeWays.swift
//  SwiftDSA
//
//  Created by Ray on 14/5/26.
//
//  LC 518 — Coin Change II
//
//  Given an integer array `coins` representing coin denominations and an
//  integer `amount`, return the number of distinct combinations that sum
//  to `amount`. If it cannot be made up by any combination, return 0.
//
//  You may assume an infinite supply of each coin. Combinations are
//  unordered: (1, 4) and (4, 1) count as the same combination.
//
//  Example:
//    coins = [1, 2, 5], amount = 5  -> 4   (5; 2+2+1; 2+1+1+1; 1+1+1+1+1)
//    coins = [2],       amount = 3  -> 0
//    coins = [1, 4, 8], amount = 7  -> 2   (1+1+1+4; 1*7)
//    coins = [10],      amount = 10 -> 1
//
//  Pitfall: a 1D recurrence `ways(k) = sum over c of ways(k - c)` counts
//  ordered sequences (permutations), not combinations. To count
//  combinations, the state must include which coin index is currently
//  being considered, so we never revisit earlier coins in a different
//  position.

struct CoinChangeWays {

    /// Top-down: recursion + memo on (coinIndex, remaining).
    /// Time: O(amount * coins.count). Space: O(amount * coins.count).
    static func performTopDown(_ coins: [Int], _ amount: Int) -> Int {
        return 0
    }

    /// Bottom-up tabulation. dp[a] = number of ways to make amount `a`.
    /// Loop order matters: coins outer, amounts inner → combinations.
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performBottomUp(_ coins: [Int], _ amount: Int) -> Int {
        return 0
    }
}
