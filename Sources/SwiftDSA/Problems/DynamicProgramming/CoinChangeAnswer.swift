//
//  CoinChangeAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

struct CoinChangeAnswer {

    /// Top-down memoized recursion.
    ///
    /// Recurrence:
    ///   minCoins(rem) = 1 + min over c in coins of minCoins(rem - c), for c <= rem
    ///   minCoins(0)   = 0
    ///   minCoins(<0)  = unreachable
    ///
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performTopDown(_ coins: [Int], _ amount: Int) -> Int {
        guard amount >= 0 else { return -1 }
        if amount == 0 { return 0 }

        // memo[rem] = -2 means "not yet computed", -1 means "unreachable", else min coins.
        var memo = Array(repeating: -2, count: amount + 1)

        func minCoins(_ rem: Int) -> Int {
            if rem == 0 { return 0 }
            if rem < 0 { return -1 }
            if memo[rem] != -2 { return memo[rem] }

            var best = Int.max
            for c in coins {
                let sub = minCoins(rem - c)
                if sub != -1 {
                    best = min(best, sub + 1)
                }
            }

            let result = best == Int.max ? -1 : best
            memo[rem] = result
            return result
        }

        return minCoins(amount)
    }

    /// Bottom-up tabulation.
    ///
    /// dp[a] = fewest coins to make amount `a`.
    /// Sentinel `amount + 1` represents "unreachable" (greater than any valid answer).
    ///
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performBottomUp(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 0 }
        if amount < 0 { return -1 }

        let unreachable = amount + 1
        var dp = Array(repeating: unreachable, count: amount + 1)
        dp[0] = 0

        for a in 1...amount {
            for c in coins where c <= a {
                dp[a] = min(dp[a], dp[a - c] + 1)
            }
        }

        return dp[amount] == unreachable ? -1 : dp[amount]
    }
}
