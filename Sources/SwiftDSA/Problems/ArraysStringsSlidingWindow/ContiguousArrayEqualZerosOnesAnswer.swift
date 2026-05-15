//
//  ContiguousArrayEqualZerosOnesAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//

struct ContiguousArrayEqualZerosOnesAnswer {

    /// Map 0 -> -1, 1 -> +1, then find the longest subarray with sum 0.
    ///
    /// After the substitution, equal counts of 0s and 1s in a subarray means
    /// its transformed sum is 0, i.e. two prefix sums are equal. Record the
    /// EARLIEST index at which each prefix sum is seen; whenever we revisit a
    /// prefix sum, the gap is a candidate answer. Seed `{0: -1}` so balanced
    /// prefixes starting at index 0 are handled uniformly.
    ///
    /// Time:  O(n).
    /// Space: O(n) — at most n distinct prefix sums in the worst case.
    static func perform(_ nums: [Int]) -> Int {
        var firstIndex: [Int: Int] = [0: -1]
        var runningSum = 0
        var best = 0

        for j in 0..<nums.count {
            runningSum += (nums[j] == 1 ? 1 : -1)

            if let i = firstIndex[runningSum] {
                best = max(best, j - i)
            } else {
                firstIndex[runningSum] = j
            }
        }

        return best
    }
}
