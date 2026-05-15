//
//  LongestSubarrayDivisibleByKAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//

struct LongestSubarrayDivisibleByKAnswer {

    /// Prefix sums keyed by remainder mod k.
    ///
    /// A subarray (i+1..j) has sum divisible by k iff prefix[j] % k == prefix[i] % k.
    /// To maximise the length j - i, we want the EARLIEST index at which each
    /// remainder was first observed. Seed with {0: -1} so that a prefix which
    /// is itself divisible by k yields length j - (-1) = j + 1.
    ///
    /// Swift's `%` can produce negative remainders for negative dividends, so
    /// normalise via `((sum % k) + k) % k` before using as a key.
    ///
    /// Time:  O(n).
    /// Space: O(min(n, k)) — at most k distinct remainders.
    static func perform(_ nums: [Int], _ k: Int) -> Int {
        var firstIndex: [Int: Int] = [0: -1]
        var runningSum = 0
        var best = 0

        for j in 0..<nums.count {
            runningSum += nums[j]
            let r = ((runningSum % k) + k) % k

            if let i = firstIndex[r] {
                best = max(best, j - i)
            } else {
                firstIndex[r] = j
            }
        }

        return best
    }
}
