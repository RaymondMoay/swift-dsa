//
//  LongestCommonSubsequence.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//
//  LC 1143 — Longest Common Subsequence
//
//  Given two strings `text1` and `text2`, return the length of their longest
//  common subsequence. If there is no common subsequence, return 0.
//
//  A subsequence preserves order but does not need to be contiguous:
//    "ace" is a subsequence of "abcde".
//
//  Foundational 2D DP — recurrence:
//    lcs(i, j) =
//      0                                if i == 0 or j == 0
//      lcs(i-1, j-1) + 1                if text1[i-1] == text2[j-1]
//      max(lcs(i-1, j), lcs(i, j-1))    otherwise
//
//  Example:
//    text1 = "abcde", text2 = "ace" -> 3   ("ace")
//    text1 = "abc",   text2 = "abc" -> 3
//    text1 = "abc",   text2 = "def" -> 0

struct LongestCommonSubsequence {
    
    // text1 = "abcde", text2 = "abde" -> 4
    
    /// Top-down: recursion on (i, j) with 2D memo.
    /// Time: O(m * n). Space: O(m * n).
    static func performTopDown(_ text1: String, _ text2: String) -> Int {
        
        let left = Array(text1)
        let right = Array(text2)
        var memo: [[Int]] = Array(repeating: Array(repeating: -1, count: right.count), count: left.count)
        
        func lcs(_ lIdx: Int, _ rIdx: Int) -> Int {
            // base cases
            if lIdx < 0 || rIdx < 0 { return 0 }
            
            if memo[lIdx][rIdx] != -1 {
                return memo[lIdx][rIdx]
            }

            // recurse
            // pre
            var result = 0
            // recurse
            if left[lIdx] == right[rIdx] {
                result = lcs(lIdx - 1, rIdx - 1) + 1
            } else {
                result = max(lcs(lIdx - 1, rIdx), lcs(lIdx, rIdx - 1))
            }
            // posts
            memo[lIdx][rIdx] = result
            return result
        }
        
        return lcs(left.count - 1, right.count - 1)
    }

    /// Bottom-up tabulation.
    /// Time: O(m * n). Space: O(m * n).
    static func performBottomUp(_ text1: String, _ text2: String) -> Int {
        // TODO: implement
        return 0
    }
}
