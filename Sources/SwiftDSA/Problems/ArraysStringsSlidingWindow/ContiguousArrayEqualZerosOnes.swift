//
//  ContiguousArrayEqualZerosOnes.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//
//  LC 525 — Contiguous Array
//
//  Given a binary array `nums` (each element is 0 or 1), return the maximum
//  length of a contiguous subarray with an equal number of 0s and 1s.
//
//  Example:
//    nums = [0, 1]              -> 2     ([0, 1])
//    nums = [0, 1, 0]           -> 2     ([0, 1] or [1, 0])
//    nums = [0, 0, 1, 0, 0, 0, 1, 1]
//                                -> 6     ([0, 1, 0, 0, 0, 1] — 3 zeros, 3 ones... wait,
//                                          actually [1, 0, 0, 0, 1, 1] has 3 zeros and
//                                          3 ones, length 6. Various 6-length answers
//                                          exist.)
//
//  Constraints:
//    1 <= nums.count <= 10^5
//    nums[i] is 0 or 1.
//
//  The trick — turn 0s into -1s:
//    A subarray has equal 0s and 1s iff (#ones - #zeros) == 0.
//    Replace every 0 with -1; now we want the longest subarray whose SUM is 0.
//    Each 1 contributes +1, each -1 (originally 0) contributes -1; equal counts
//    cancel to zero.
//
//  Why prefix sum + hashmap works:
//    sum(transformed[i+1..j]) == 0
//      <=> prefix[j] == prefix[i]
//    So we look for two indices with the SAME prefix sum, as far apart as
//    possible.
//
//  Hints:
//    - Store {prefixSum: earliest_index}. Want EARLIEST because we maximise length.
//    - Seed the map with `[0: -1]` so an array prefix that is itself balanced
//      gives length j - (-1) = j + 1.
//    - Either build a transformed array OR fold the substitution into the
//      running-sum update: add +1 for 1s, -1 for 0s.
//
//  Target: O(n) time, O(n) space.

struct ContiguousArrayEqualZerosOnes {

    static func perform(_ nums: [Int]) -> Int {
        return 0
    }
}
