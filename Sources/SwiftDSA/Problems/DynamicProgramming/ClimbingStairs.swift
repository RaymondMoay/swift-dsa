//
//  ClimbingStairs.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//
//  LC 70 — Climbing Stairs
//
//  You are climbing a staircase with `n` steps. Each time you can either
//  climb 1 or 2 steps. In how many distinct ways can you climb to the top?
//
//  Example:
//    n = 2 -> 2  (1+1, 2)
//    n = 3 -> 3  (1+1+1, 1+2, 2+1)
//    n = 4 -> 5
//
//  Constraints: 1 <= n <= 45

struct ClimbingStairs {

    /// Top-down: recursion + memoization. O(n) time, O(n) space.
    static func performTopDown(_ n: Int) -> Int {
        
        var memo: [Int] = Array(repeating: -1, count: n + 1)
        
        func numberOfWays(_ n: Int) -> Int {
            // base case
            if n == 1 { return 1 }
            if n == 2 { return 2 }
            // recurse
            // pre
            if memo[n] != -1 { return memo[n] }
            // curr
            let result = numberOfWays(n - 1) + numberOfWays(n - 2)
            // post
            memo[n] = result
            return result
        }
        
        return numberOfWays(n)
    }

    /// Bottom-up: tabulation. O(n) time, O(n) space.
    static func performBottomUp(_ n: Int) -> Int {
        var memo: [Int] = Array(repeating: -1, count: n + 1)
        
        for i in 1...n {
            var result: Int = 0
            // base
            if i <= 2 {
                result = i
            } else {
                result = memo[i - 1] + memo[i - 2]
            }
            memo[i] = result
        }
        
        return memo[n]
    }

    /// Bottom-up with O(1) space — only the last two values are needed.
    static func performOptimized(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        
        var prev2 = 1
        var prev1 = 2
        
        for _ in 3...n {
            let temp = prev1
            prev1 += prev2
            prev2 = temp
        }
        
        return prev1
    }
}
