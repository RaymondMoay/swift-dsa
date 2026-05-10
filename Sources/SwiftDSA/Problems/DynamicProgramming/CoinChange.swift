//
//  CoinChange.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//
//  LC 322 — Coin Change
//
//  Given an integer array `coins` representing coin denominations and an
//  integer `amount`, return the fewest number of coins needed to make up
//  that amount. If the amount cannot be made up by any combination, return -1.
//
//  You may assume an infinite supply of each coin.
//
//  Payments framing: minimum number of operations / retries to reach
//  a target state — e.g., the smallest set of fixed-denomination cashout
//  payouts that sum to a refund amount.
//
//  Example:
//    coins = [1,2,5], amount = 11 -> 3   (5 + 5 + 1)
//    coins = [2],     amount = 3  -> -1
//    coins = [1],     amount = 0  -> 0

struct CoinChange {

    /// Top-down: recursion + memo on remaining amount. Returns -1 if unreachable.
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performTopDown(_ coins: [Int], _ amount: Int) -> Int {
        
        /// answer = min of its constituents
        /// coins [1,3,5], amount = 17
        /// min(17) = min(min(12) + min(5), min(14) + min(3), min(16) + min(1))
        /// I can loop through all the different mins, and find the lowest value...
        ///
        /// /// coins [2], amount = 3
        /// min(3) = min(min(12) + min(5), min(14) + min(3), min(16) + min(1))
        ///
        /// base
        /// if amount == 0 { return 0 }
        /// if coins.contain(amount) { return 1 }
        /// if amount <= 1 { return -1 }
        ///
        /// recurse
        ///
        /// var lowest = Int.max
        /// for i in 0..<coins.count {
        ///     let min = min(amount-coin) + min(coin)
        ///         /// POST OP
        ///     if min < lowest { lowest = min }
        /// }
        /// if lowest <= 0 { lowest = -1 }
        /// return lowest
        ///
        ///
        /// Base case for -1, how do I do that? Coins = [2,4], amount = 9
        /// min(9) = min(-1 + 1 = 0 -> -1, -1 + 1 = 0 -> -1) -> -1
        ///     min(7) = min(-1 + 1 = 0 -> -1, -1 + 1 = 0 -> -1)
        ///             min(5) = min[0, 0] -> 0 -> -1
        ///                 min(3) = min(1) + min(2) -> 0 -> -1
        ///
        /// Base case for -1, Coins = [5], amount = [7]
        /// min(7) = min(2) + min(5) = 0 -> -1
        ///     min(2) = min(-3) + min(5) = 0 -> -1
        ///
        /// Coins = [1, 2, 5], 11
        /// min(11) = min(6) + min(5) = 3
        ///     min(6) = min(5) + min(1) = 1 + 1 = 2
        /// min(11) = min(9) + min(2)
        ///     min(9) = min(4) + min(5) || min(7) + min(2)
        ///         min(4) = min[min(2) + min(2) || min(-1) + min(5)] = min(2 || -1) <-- lowest is -1, but we can do it 2 times!
        
        var memo: [Int] = Array(repeating: Int.max, count: amount + 1)
        
        func minChange(_ coins: [Int], _ amount: Int) -> Int {
            // base case
            if amount == 0 { return 0 }
            if amount < 0 { return -1 }
            if memo[amount] != Int.max { return memo[amount] }
            
            // recurse
            var lowest: Int = Int.max
            for coin in coins {
                let change = minChange(coins, amount - coin) // min change at -1 means you "can't" make a change!
                guard change >= 0 else { continue } // if its possible to make a change!
                let currentMin = change + 1
                if currentMin < lowest {
                    lowest = currentMin
                }
            }
            if lowest == Int.max {
                lowest = -1
            }
            memo[amount] = lowest
            return lowest
        }
        
        return minChange(coins, amount)
    }

    /// Bottom-up tabulation. dp[a] = min coins to make amount `a`.
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performBottomUp(_ coins: [Int], _ amount: Int) -> Int {
        guard amount >= 0 else { return -1 }
        guard amount > 0 else { return 0 }
        if amount == 1 {
            if coins.contains(1) {
                return 1
            } else {
                return -1
            }
        }
        
        var memo: [Int] = Array(repeating: Int.max, count: amount + 1)
        memo[0] = 0 // seed case
        
        for i in 1...amount {
            var lowest: Int = Int.max
            for coin in coins {
                let diff = i - coin
                guard diff >= 0 else { continue }
                guard memo[diff] != -1 else { continue }
                let current = memo[diff] + 1
                if current < lowest {
                    lowest = current
                }
            }
            if lowest == Int.max {
                lowest = -1
            }
            memo[i] = lowest
        }
        
        return memo[amount]
    }
}
