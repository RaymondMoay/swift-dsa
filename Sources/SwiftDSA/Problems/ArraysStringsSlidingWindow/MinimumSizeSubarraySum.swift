//
//  MinimumSizeSubarraySum.swift
//  SwiftDSA
//
//  Created by Ray on 5/13/26.
//
//  LC 209 — Minimum Size Subarray Sum
//
//  Given an array of positive integers `nums` and a positive integer `target`,
//  return the minimal length of a contiguous subarray whose sum is >= target.
//  If no such subarray exists, return 0.
//
//  Example:
//    nums = [2, 3, 1, 2, 4, 3], target = 7  -> 2   ([4, 3] has sum 7)
//    nums = [1, 4, 4],          target = 4  -> 1
//    nums = [1, 1, 1, 1],       target = 11 -> 0
//
//  Constraints:
//    1 <= target <= 10^9
//    1 <= nums.count <= 10^5
//    1 <= nums[i] <= 10^4   (positive — required for sliding window)
//
//  Why sliding window works:
//    All elements are positive, so:
//      - Expanding right strictly increases windowSum.
//      - Shrinking left strictly decreases windowSum.
//    That monotonicity lets us advance `right` until the window is valid, then
//    shrink `left` as much as possible while it stays valid, recording the
//    shortest length seen. Both pointers only move forward => O(n).
//
//  Hints:
//    - Track `windowSum` and `left`.
//    - For each `right`, add nums[right]; while windowSum >= target,
//      record (right - left + 1), then subtract nums[left] and advance left.
//    - Use Int.max as a sentinel for "no valid window found yet"; convert to 0
//      at the end.
//
//  Target: O(n) time, O(1) space.

struct MinimumSizeSubarraySum {

    static func perform(_ target: Int, _ nums: [Int]) -> Int {
        
        var left: Int = 0
        var minLength: Int = Int.max
        var runningSum: Int = 0
        
        for right in 0..<nums.count {
            // Advance the right
            runningSum += nums[right]
            // Should we advance the left?
            /// Advance the left, if advancing the left does not reduce sum less than target
            /// AND left does not exceed right (break the window)
            while runningSum - nums[left] >= target && left <= right {
                runningSum -= nums[left]
                left += 1
            }
            // Now we calculate
            if runningSum >= target {
                minLength = min(minLength, nums[left...right].count)
            }
        }
        
        if minLength == Int.max {
            return 0
        } else {
            return minLength
        }
    }
}
