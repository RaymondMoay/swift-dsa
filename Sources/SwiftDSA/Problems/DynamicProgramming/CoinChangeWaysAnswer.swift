//
//  CoinChangeWaysAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 14/5/26.
//

struct CoinChangeWaysAnswer {

    /// Top-down memoized recursion.
    ///
    /// State: (i, remaining) — "considering coins[i...], how many ways to make `remaining`?"
    /// The `i` parameter is what prevents counting permutations: once we move
    /// past a coin, we never come back to it in a different position.
    ///
    /// Recurrence:
    ///   ways(i, 0)         = 1                                          // empty selection is one valid way
    ///   ways(i, rem)       = 0   if i == coins.count                    // no coins left, didn't reach 0
    ///   ways(i, rem)       = ways(i + 1, rem)                           // skip coin i entirely
    ///                      + ways(i, rem - coins[i])  if rem >= coins[i] // use one more of coin i (stay at i)
    ///
    /// Time: O(amount * coins.count). Space: O(amount * coins.count).
    static func performTopDown(_ coins: [Int], _ amount: Int) -> Int {
        if amount == 0 { return 1 }
        if amount < 0 || coins.isEmpty { return 0 }

        var memo = Array(
            repeating: Array(repeating: -1, count: amount + 1),
            count: coins.count
        )

        func ways(_ i: Int, _ remaining: Int) -> Int {
            if remaining == 0 { return 1 }
            if i == coins.count { return 0 }
            if memo[i][remaining] != -1 { return memo[i][remaining] }

            var result = ways(i + 1, remaining) // skip coin i
            if remaining >= coins[i] {
                result += ways(i, remaining - coins[i]) // use one more of coin i
            }

            memo[i][remaining] = result
            return result
        }

        return ways(0, amount)
    }

    /// Bottom-up tabulation, flattened to 1D.
    ///
    /// dp[a] = number of combinations summing to `a` using the coins processed so far.
    ///
    /// Loop order is the crux:
    ///   - coins OUTER, amounts INNER → combinations (each coin gets fully processed
    ///     before the next, so (1, 4) and (4, 1) collapse to the same selection).
    ///   - amounts outer, coins inner → permutations (each amount reconsiders every
    ///     coin, double-counting ordered sequences).
    ///
    /// Time: O(amount * coins.count). Space: O(amount).
    static func performBottomUp(_ coins: [Int], _ amount: Int) -> Int {
        if amount < 0 { return 0 }

        var dp = Array(repeating: 0, count: amount + 1)
        dp[0] = 1 // one way to make 0: pick nothing

        for coin in coins {
            guard coin <= amount else { continue }
            for a in coin...amount {
                dp[a] += dp[a - coin]
            }
        }

        return dp[amount]
    }
}
