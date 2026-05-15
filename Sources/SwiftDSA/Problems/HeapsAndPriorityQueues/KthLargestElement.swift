//
//  KthLargestElement.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 215 — Kth Largest Element in an Array
//
//  Given an integer array `nums` and an integer `k`, return the kth largest
//  element in the array. Note that it is the kth largest element in *sorted
//  order*, not the kth distinct element.
//
//  Example:
//    Input:  nums = [3, 2, 1, 5, 6, 4], k = 2
//    Output: 5
//
//    Input:  nums = [3, 2, 3, 1, 2, 4, 5, 5, 6], k = 4
//    Output: 4
//
//  Constraints:
//    - 1 <= k <= nums.count <= 10^5
//    - -10^4 <= nums[i] <= 10^4
//
//  Hints:
//    - The "obvious" answer is sort + index: O(n log n). Beat it.
//    - Maintain a *min-heap* of size k while scanning. The top of the heap is
//      always the smallest of the k largest values seen so far — which, once
//      you have seen every element, *is* the kth largest.
//    - When the heap grows past size k, pop the minimum. The pop is O(log k),
//      not O(log n).
//
//  Target:
//    Time:  O(n log k) — significantly better than O(n log n) when k << n.
//    Space: O(k) for the heap.
//
//  Interviewer hint (concept check):
//    Be ready to explain *why* a min-heap (not a max-heap) for "kth largest".
//    Intuition: a min-heap of size k keeps the *k largest* values and lets you
//    cheaply evict the smallest of them. The eventual top is the kth largest.
//    A max-heap of size n works too but is O(n) space and worse cache locality.
//
//  Stretch:
//    - Quickselect achieves O(n) average / O(n^2) worst case with O(1) extra
//      space. Mention it as the optimal alternative when k is close to n/2.

struct KthLargestElement {

    /// Returns the kth largest element of `nums`.
    static func find(_ nums: [Int], k: Int) -> Int {
        
        /// Since im getting Kth largest element, I will probably use a capped min heap, where adding new items will pop-off old elements.
        /// At every iteration, we are popping off the smallest element. And once we reach the end, we are left with the Kth largest at the top, where i can pop it off at O(1).
        
        class MinHeap {
            
            var container: [Int]
            let capacity: Int
            
            init(size: Int) {
                self.container = Array(repeating: -1, count: size)
                self.capacity = size
            }
            
            // MARK: Private helpers:
            
            private func heapifyUp(_ idx: Int) {
                let parentIdx = parentIndex(of: idx)
                
                let parentValue = container[parentIdx]
                let value = container[idx]
                
                if value < parentValue {
                    container.swapAt(parentIdx, idx)
                    heapifyUp(parentIdx)
                }
            }
            
            private func heapifyDown(_ idx: Int) {
                let leftIdx = leftChildIndex(of: idx)
                let rightIdx = rightChildIndex(of: idx)
            }
            
            private func parentIndex(of idx: Int) -> Int {
                (idx - 1) / 2
            }
            
            private func leftChildIndex(of idx: Int) -> Int {
                2*idx + 1
            }
            
            private func rightChildIndex(of idx: Int) -> Int {
                2*idx + 2
            }
        }
        
        return 0
    }
}
