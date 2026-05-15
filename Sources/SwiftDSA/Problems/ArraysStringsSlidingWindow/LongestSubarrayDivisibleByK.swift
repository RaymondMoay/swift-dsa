//
//  LongestSubarrayDivisibleByK.swift
//  SwiftDSA
//
//  Created by Ray on 5/14/26.
//
//  Longest Subarray With Sum Divisible by K
//
//  Given an integer array `nums` (may contain negatives) and a positive integer
//  `k`, return the length of the longest contiguous subarray whose sum is
//  divisible by `k`. If no such subarray exists, return 0.
//
//  Example:
//    nums = [2, 7, 6, 1, 4, 5],   k = 3  -> 4   ([7, 6, 1, 4] sums to 18)
//    nums = [-1, 2, 9],           k = 2  -> 2   ([-1, 9] -> wait, not contiguous;
//                                                actually [2] is not divisible,
//                                                so let's reason: prefix sums
//                                                -1, 1, 10. Mods (k=2): 1, 1, 0.
//                                                Two prefixes with mod=1 at idx 0
//                                                and 1 -> subarray (1..1) of len 1.
//                                                Prefix mod=0 at idx 2 means
//                                                subarray (0..2) of len 3 divisible
//                                                by 2 (sum 10). So answer = 3.)
//    nums = [4, 5, 0, -2, -3, 1], k = 5  -> 6   (whole array sums to 5)
//
//  Constraints:
//    1 <= nums.count <= 10^5
//    -10^4 <= nums[i] <= 10^4
//    2 <= k <= 10^4
//
//  Why sliding window fails:
//    `nums` can contain negatives, so the running sum isn't monotonic and there
//    is no "shrink/expand" direction based on the divisibility property.
//
//  Why prefix sum + hashmap works:
//    sum(nums[i+1..j]) is divisible by k
//      <=> (prefix[j] - prefix[i]) % k == 0
//      <=> prefix[j] % k == prefix[i] % k
//    So we want the two indices with the SAME prefix-sum remainder mod k that
//    are as far apart as possible.
//
//  Hints:
//    - Store {remainder: earliest_index_at_which_we_saw_it}. We want EARLIEST
//      because the answer is a LENGTH (we want the widest range).
//    - Seed the map with `[0: -1]` so a prefix that itself is divisible by k
//      gives a subarray (0..j) of length j - (-1) = j + 1.
//    - In Swift, the `%` operator can return negative values for negative
//      operands. Normalise: `let r = ((sum % k) + k) % k`.
//    - Only insert into the map if the remainder hasn't been seen yet — we
//      want the EARLIEST occurrence preserved.
//
//  Target: O(n) time, O(min(n, k)) space.

struct LongestSubarrayDivisibleByK {

    static func perform(_ nums: [Int], _ k: Int) -> Int {
        
        /// nums = [2, 7, 6, 1, 4, 5],   k = 3  -> 4
        /// Naive way: O(n^2)
        
        /// O(n) -> prefix sum
        
        /// (prefix[j] - prefix[start]) % 3 = 0
        /// prefix[j] % 3 = prefix[start] % 3
        /// This means, for their sums to % 3 == 0, the remainder of both must be equal
        
        var seen: [Int: Int] = [0: 0] // remainder : smallest index i've seen for this remainder
        var runningSum: Int = 0
        var result: Int = 0 // everytime i traverse, i ask, hey the remainder of the current altitude is 5, when was the last time i saw an altitude with a remainder of 5? Oh, 2, ok, so length = j - i + 1
        
        for i in 0..<nums.count {
            runningSum += nums[i]
            let remainder = runningSum % k
            // when was the last time I saw this?
            if let lastIndex = seen[remainder] {
                let length = i - lastIndex
                result = max(result, length)
            }
            seen[remainder] = i
        }
        return result
    }
}
