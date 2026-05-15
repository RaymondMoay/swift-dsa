//
//  LongestSubstringWithoutRepeating.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 3 — Longest Substring Without Repeating Characters
//
//  Given a string `s`, find the length of the longest substring without
//  repeating characters.
//
//  Example:
//    s = "abcabcbb" -> 3   ("abc")
//    s = "bbbbb"    -> 1   ("b")
//    s = "pwwkew"   -> 3   ("wke" — note: "pwke" is a subsequence, not a substring)
//    s = ""         -> 0
//
//  Constraints:
//    0 <= s.count <= 5 * 10^4
//    s consists of English letters, digits, symbols and spaces.
//
//  Hints:
//    - Sliding window with two pointers (left, right).
//    - Track the last seen index of each character in a dictionary.
//    - When a duplicate is seen inside the window, advance `left` past the
//      previous occurrence.
//
//  Target: O(n) time, O(min(n, alphabet)) space.

struct LongestSubstringWithoutRepeating {

    static func perform(_ s: String) -> Int {

        // principles – sliding window
        /// 1. monothic property -> move one direction. If left moves up, we are removing. If right moves up, we are adding.
        /// 2. Substring / subarray, rather than a subsequence (as long as its contiguous, it should work)
        
        let word = Array(s)
        var counter: [Character: Int] = [:]
        var left: Int = 0
        var highest: Int = 0
        
        for right in 0..<s.count {
            let char = word[right]
            if let prevIndex = counter[char], prevIndex >= left {
                left = prevIndex + 1
            }
            counter[char] = right
            highest = max(highest, right - left + 1)
        }
        return highest
    }
}
