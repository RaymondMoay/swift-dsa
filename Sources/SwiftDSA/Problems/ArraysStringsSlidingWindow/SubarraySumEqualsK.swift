//
//  SubarraySumEqualsK.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 560 — Subarray Sum Equals K
//
//  Given an integer array `nums` and an integer `k`, return the total number
//  of contiguous subarrays whose sum equals `k`.
//
//  Example:
//    nums = [1, 1, 1],     k = 2  -> 2    ([1,1] at idx 0..1 and 1..2)
//    nums = [1, 2, 3],     k = 3  -> 2    ([1,2] and [3])
//    nums = [1, -1, 0],    k = 0  -> 3    ([1,-1], [0], [1,-1,0])
//
//  Constraints:
//    1 <= nums.count <= 2 * 10^4
//    -1000 <= nums[i] <= 1000
//    -10^7 <= k <= 10^7
//
//  Note:
//    A sliding window does NOT work here because `nums` may contain negatives,
//    so growing the window can decrease the sum. The intended technique is
//    prefix sums + a hashmap of how often each prefix sum has been seen:
//      sum(i..j) = prefix[j] - prefix[i-1] == k
//      => prefix[i-1] == prefix[j] - k
//
//  Hints:
//    - Initialise counts with `[0: 1]` so a prefix that itself equals k counts.
//    - Walk the array maintaining a running sum. For each index, look up
//      `runningSum - k` in the map and add its count to the answer.
//
//  Target: O(n) time, O(n) space.

struct SubarraySumEqualsK {

    static func perform(_ nums: [Int], _ k: Int) -> Int {
        
        /// naive solution: iterate through sum, and for each, iterate its subsequent array to calculate a given condition. Sum == k O(n^2)
        
        /// O(n) <-- goal
        /// at every iteration -> accounting
        ///
        /// Prefix sum
        ///
        ///item:    1 -1 3 2 4 6
        ///sum:    1  0 3 5 9 15
        
        /// climbing a mountain, runningSum = altitude
        /// runningSum - k = starting point <-- have i seen this before?
        ///
        
        /// [-1, 1, 0], k = 0
        ///
        ///
        
        var seen: [Int: Int] = [0: 1]
        var runningSum: Int = 0
        var count: Int = 0
        
        for i in 0..<nums.count {
            runningSum += nums[i]
            // now that I am at a given altitude, is the net path to get here ever == k?
            let startPoint = runningSum - k
            if let timesSeen = seen[startPoint] {
                count += timesSeen
            }
            seen[runningSum, default: 0] += 1
        }
        return count
    }
}
