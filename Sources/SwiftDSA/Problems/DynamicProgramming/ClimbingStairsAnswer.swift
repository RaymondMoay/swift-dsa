//
//  ClimbingStairsAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

struct ClimbingStairsAnswer {

    /// Top-down: f(n) = f(n-1) + f(n-2), with memo to dedupe overlapping subproblems.
    /// Time: O(n) — each subproblem computed once.
    /// Space: O(n) — memo + recursion stack.
    static func performTopDown(_ n: Int) -> Int {
        var memo = Array(repeating: -1, count: n + 1)

        func ways(_ i: Int) -> Int {
            if i <= 2 { return i }
            if memo[i] != -1 { return memo[i] }

            let result = ways(i - 1) + ways(i - 2)
            memo[i] = result
            return result
        }

        return ways(n)
    }

    /// Bottom-up tabulation. dp[i] = dp[i-1] + dp[i-2].
    /// Time: O(n). Space: O(n).
    static func performBottomUp(_ n: Int) -> Int {
        if n <= 2 { return n }

        var dp = Array(repeating: 0, count: n + 1)
        dp[1] = 1
        dp[2] = 2

        for i in 3...n {
            dp[i] = dp[i - 1] + dp[i - 2]
        }

        return dp[n]
    }

    /// Same recurrence, O(1) space — only need previous two values.
    /// Time: O(n). Space: O(1).
    static func performOptimized(_ n: Int) -> Int {
        if n <= 2 { return n }

        var prev2 = 1
        var prev1 = 2

        for _ in 3...n {
            let curr = prev1 + prev2
            prev2 = prev1
            prev1 = curr
        }

        return prev1
    }
}
