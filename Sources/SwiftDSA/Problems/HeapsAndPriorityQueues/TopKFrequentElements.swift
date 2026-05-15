//
//  TopKFrequentElements.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 347 — Top K Frequent Elements
//
//  Given an integer array `nums` and an integer `k`, return the k most frequent
//  elements. You may return the answer in any order.
//
//  Example:
//    Input:  nums = [1, 1, 1, 2, 2, 3], k = 2
//    Output: [1, 2]            (any order)
//
//    Input:  nums = [1], k = 1
//    Output: [1]
//
//  Constraints:
//    - 1 <= nums.count <= 10^5
//    - k is in the range [1, number of unique elements in nums]
//    - The answer is *guaranteed* to be unique.
//
//  Hints:
//    - First pass: build a frequency dictionary `[Int: Int]`.
//    - Then maintain a **min-heap of size k** keyed on frequency. Push every
//      `(count, num)`; once the heap exceeds size k, pop the min. The heap's
//      final contents are the k most frequent elements.
//    - You compare by *count*, but the payload is the element itself.
//
//  Target:
//    Time:  O(n log k)  — n for the count pass, n log k for the heap pass.
//    Space: O(n)        — frequency dictionary dominates.
//
//  Why this models a real payments problem:
//    "Show the user their top-N merchants by spend frequency" — same shape.
//    The data set may be huge (months of transactions), but N is small (5–10).
//    A size-k heap is the right tool exactly because it bounds memory by k,
//    not by the unbounded set of merchants.
//
//  Stretch:
//    - Bucket sort gives O(n) time at the cost of O(n) extra space: index a
//      buckets array by frequency, then scan buckets from high to low until
//      you have collected k elements. Mention this as the optimal solution
//      when k is close to the number of unique elements.

struct TopKFrequentElements {

    /// Returns the k most frequent elements of `nums`, in any order.
    static func find(_ nums: [Int], k: Int) -> [Int] {
        // TODO: your answer here
        return []
    }
}
