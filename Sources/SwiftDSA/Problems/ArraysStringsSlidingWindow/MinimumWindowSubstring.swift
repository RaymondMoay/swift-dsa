//
//  MinimumWindowSubstring.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 76 — Minimum Window Substring
//
//  Given two strings `s` and `t` of lengths m and n respectively, return the
//  minimum window substring of `s` such that every character in `t` (including
//  duplicates) is contained in the window. If there is no such substring,
//  return the empty string "".
//
//  Example:
//    s = "ADOBECODEBANC", t = "ABC"   -> "BANC"
//    s = "a",            t = "a"     -> "a"
//    s = "a",            t = "aa"    -> ""    (need two 'a's, only one in s)
//
//  Constraints:
//    m == s.count, n == t.count
//    1 <= m, n <= 10^5
//    s and t consist of uppercase and lowercase English letters.
//
//  Hints:
//    - Variable-size sliding window.
//    - Track required counts from `t` and "have" counts inside the window.
//    - Maintain a `formed` counter: how many distinct characters in the window
//      currently meet their required count. When `formed == required`, try to
//      shrink from the left while the window remains valid.
//
//  Target: O(m + n) time, O(|alphabet|) space.

struct MinimumWindowSubstring {

    static func perform(_ s: String, _ t: String) -> String {
        var sWord = Array(s)
        var tWord = Array(t)
        
        var left: Int = 0
        var havePosition: [(c: Character, i: Int)] = []
        var haveCount: [Character: Int] = [:]
        var needCount: [Character: Int] = [:]
        
        for c in t {
            haveCount[c] = 0
            needCount[c] = t.count(where: { $0 == c })
        }
        
        for right in 0..<sWord.count {
            let c = sWord[right]
            // keep progressing, until we have all 3
            if tWord.contains(c) && haveCount[c] != needCount[c] {
                havePosition.append((c: c, i: right))
                haveCount[c]! += 1
            }
            
            if tWord.contains(c) {
                // can we move left forward, without losing the min requirements.
                // if it contains, it means what we leave behind (left)
                let tailWord = tWord[left]
                if tailWord == c {
                    /// move left to the furthest it can be while still holding the equation
                    for pos in havePosition {
                        if pos.c == tailWord {
                            continue
                        } else {
                            left = pos.i
                            break
                        }
                    }
                    continue
                }
            }
        }
        
        /// ADOBECODEBANC
        /// Iteration 1: ADOBEC
        ///
        /// What makes us move the left pointer up?
        /// - When we reach B, how much can we move left pointer forward, such that we sitll have the correct alphabets.

        
        return ""
    }
}
