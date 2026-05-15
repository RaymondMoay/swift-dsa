//
//  FindAllAnagrams.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 438 — Find All Anagrams in a String
//
//  Given two strings `s` and `p`, return an array of all the start indices in
//  `s` of substrings that are anagrams of `p`. The result may be in any order.
//
//  An anagram is a rearrangement of all the original letters exactly once.
//
//  Example:
//    s = "cbaebabacd", p = "abc"  -> [0, 6]
//      ("cba" at 0 and "bac" at 6 are anagrams of "abc")
//
//    s = "abab", p = "ab"          -> [0, 1, 2]
//
//  Constraints:
//    1 <= s.count, p.count <= 3 * 10^4
//    s and p consist of lowercase English letters.
//
//  Hints:
//    - Fixed-size sliding window of length p.count.
//    - Track character frequency inside the window and compare to the
//      frequency of `p`. A naive compare is O(26) per step which is fine.
//    - For tighter performance keep a `matches` counter (how many letters
//      a..z currently have matching counts) and update it incrementally.
//
//  Target: O(n) time, O(1) space (alphabet is 26 lowercase letters).

struct FindAllAnagrams {

    static func perform(_ s: String, _ p: String) -> [Int] {
        /// `cbaebabacd`
        /// `abc`
        ///
        /// Sliding window, and a fixed one of size p.count
        /// Keep sliding and move up unitl right <= s.count
        /// While sliding, always check the contents of the sliding window, and compare to p (exactly 1)
        ///
        /// The comparison should be optimised.
        /// Naive way -> is to loop through each c in sliding window, and compare it to p, then increment the counter
        ///
        /// Once each hits one, return append the left
        
        var result: [Int] = []
        let sArray = Array(s)
        var counter: [Character: Int] = [:]
        for c in p {
            if let currentCount = counter[c] {
                counter[c] = currentCount + 1
            } else {
                counter[c] = 0
            }
        }
        let resetCounter = counter
        
        for right in (p.count - 1)..<s.count {
            let left = right - (p.count - 1)
            let windowContents = sArray[left...right]
            
            for c in windowContents {
                guard let currentCount = counter[c], currentCount > 0 else {
                    // does not contain the word OR currentCount is depleted
                    break
                }
                counter[c] = currentCount - 1
            }
            
            if counter.values.allSatisfy({ $0 == 0 }) {
                result.append(left)
            }
            
            counter = resetCounter
        }
        
        return result
    }
}
