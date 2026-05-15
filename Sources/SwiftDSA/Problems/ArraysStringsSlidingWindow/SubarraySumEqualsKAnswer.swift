//
//  SubarraySumEqualsKAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct SubarraySumEqualsKAnswer {

    /// Prefix sums + hashmap.
    ///
    /// Let prefix[j] = nums[0] + ... + nums[j]. A subarray (i+1..j) sums to k
    /// iff prefix[j] - prefix[i] == k, i.e. prefix[i] == prefix[j] - k.
    ///
    /// Walk the array tracking the running prefix sum and a count of how many
    /// times each prefix sum has been seen so far. For each index j, the
    /// number of valid starts ending at j is `counts[runningSum - k]`.
    ///
    /// Seed `counts` with `[0: 1]` so that a prefix which itself equals k is
    /// counted (the empty prefix).
    ///
    /// Time:  O(n).
    /// Space: O(n) — at most n distinct prefix sums.
    static func perform(_ nums: [Int], _ k: Int) -> Int {
        var counts: [Int: Int] = [0: 1]
        var runningSum = 0
        var answer = 0

        for n in nums {
            runningSum += n
            if let c = counts[runningSum - k] {
                answer += c
            }
            counts[runningSum, default: 0] += 1
        }

        return answer
    }
}
