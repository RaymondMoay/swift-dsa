/*
 ─────────────────────────────────────────────────────────────────────────────
 Problem: Counting Subarrays That Sum To A Target
 ─────────────────────────────────────────────────────────────────────────────

 You are given an array of integers `nums` and an integer `k`.

 Return the total number of contiguous, non-empty subarrays whose elements
 sum exactly to `k`.

 A subarray is a contiguous slice of the array. Two subarrays are considered
 different if they start or end at different indices, even if they contain
 the same values.

 ─────────────────────────────────────────────────────────────────────────────
 Examples
 ─────────────────────────────────────────────────────────────────────────────

   Input:  nums = [1, 1, 1],  k = 2
   Output: 2
   Explanation: The subarrays [1,1] (indices 0..1) and [1,1] (indices 1..2)
                each sum to 2.

   Input:  nums = [1, 2, 3],  k = 3
   Output: 2
   Explanation: [1, 2] and [3].

   Input:  nums = [3, 4, 7, 2, -3, 1, 4, 2],  k = 7
   Output: 4

 ─────────────────────────────────────────────────────────────────────────────
 Constraints
 ─────────────────────────────────────────────────────────────────────────────

   • 1 <= nums.count <= 2 * 10^4
   • -1000 <= nums[i] <= 1000        ← note: values can be negative or zero
   • -10^7 <= k <= 10^7

 ─────────────────────────────────────────────────────────────────────────────
 */

func numContiguousArrays(nums: [Int], k: Int) -> Int {
  // naive way: loop through each, for each, loop through subsequents and count, then track that count. O(n^2), we can do better.
  // Better way has to do some sort of operation per iteration.

  // I can think of sliding window, but nums[i] can be negative, so it would break the monotonicity conditionn of sliding window.

  // So i will use a prefix sum. Basic strategy, calculate running sum, store the last time i saw that sum in a lookup.
  // Analogy is like a mountain climber, logging the altitudes at every checkpoint. In order to see how far he climbed, simply minus checkpoint altitudes to find difference.
  // If difference needs to be k, then altitude(j) - altitude(i) = k, then altitude(j) - k = altitude(i).
  // So similar logic, but for this nums and k with prefix sums.

  // time compelxity is O(n), but space would be more with O(n) too to manage the lookup.

  var runningSum: Int = 0
  var lookup: [Int: Int] = [0: 1] // running sum: no of times i've seen this
  var count: Int = 0

  for n in nums {
    runningSum += n
    if let lastSeenCount = lookup[runningSum - k] {
      count += lastSeenCount
    }
    lookup[runningSum, default: 0] += 1
  }

  return count
}