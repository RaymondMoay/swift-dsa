//
//  MinimumSizeSubarraySumAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 5/13/26.
//

struct MinimumSizeSubarraySumAnswer {

    /// Sliding window with two forward-only pointers.
    ///
    /// Maintain a window [left...right] and its running sum. For each `right`:
    ///   1. Extend the window by adding nums[right] to windowSum.
    ///   2. While windowSum >= target, the window is valid: record its length
    ///      and try to shrink from the left to find an even shorter valid one.
    ///
    /// Because all nums are positive, windowSum is monotonic in both pointers:
    /// expanding right increases it, shrinking left decreases it. This is what
    /// guarantees each pointer only marches forward, giving O(n) total work.
    ///
    /// Time:  O(n) — `right` advances n times, `left` advances at most n times.
    /// Space: O(1).
    static func perform(_ target: Int, _ nums: [Int]) -> Int {
        var left = 0
        var windowSum = 0
        var bestLen = Int.max

        for right in 0..<nums.count {
            windowSum += nums[right]

            while windowSum >= target {
                bestLen = min(bestLen, right - left + 1)
                windowSum -= nums[left]
                left += 1
            }
        }

        return bestLen == Int.max ? 0 : bestLen
    }
}
