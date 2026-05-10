//
//  LongestCommonSubsequenceAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

struct LongestCommonSubsequenceAnswer {

    /// Top-down memoized recursion on (i, j) where i, j are 1-indexed prefix lengths.
    /// Time: O(m * n). Space: O(m * n) memo + O(m + n) stack.
    static func performTopDown(_ text1: String, _ text2: String) -> Int {
        let a = Array(text1)
        let b = Array(text2)
        let m = a.count
        let n = b.count

        var memo = Array(repeating: Array(repeating: -1, count: n + 1), count: m + 1)

        func lcs(_ i: Int, _ j: Int) -> Int {
            if i == 0 || j == 0 { return 0 }
            if memo[i][j] != -1 { return memo[i][j] }

            let result: Int
            if a[i - 1] == b[j - 1] {
                result = lcs(i - 1, j - 1) + 1
            } else {
                result = max(lcs(i - 1, j), lcs(i, j - 1))
            }

            memo[i][j] = result
            return result
        }

        return lcs(m, n)
    }

    /// Bottom-up tabulation.
    /// dp[i][j] = LCS length of text1[0..<i] and text2[0..<j].
    /// Time: O(m * n). Space: O(m * n).
    static func performBottomUp(_ text1: String, _ text2: String) -> Int {
        let a = Array(text1)
        let b = Array(text2)
        let m = a.count
        let n = b.count

        if m == 0 || n == 0 { return 0 }

        var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

        for i in 1...m {
            for j in 1...n {
                if a[i - 1] == b[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }

        return dp[m][n]
    }
}
