//
//  KthLargestElementAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 215 — Kth Largest Element in an Array.
///
/// Strategy: maintain a **min-heap of size k**. Scan the array once; for each
/// value, push it onto the heap, and if the heap grows past size k, pop the
/// minimum. When the scan finishes, the heap contains the k largest values and
/// its root is the smallest of those — i.e. the kth largest overall.
///
/// Time:  O(n log k)
/// Space: O(k)
struct KthLargestElementAnswer {

    static func find(_ nums: [Int], k: Int) -> Int {
        var heap = MinIntHeap()
        for value in nums {
            heap.push(value)
            if heap.count > k {
                _ = heap.pop()
            }
        }
        // Force-unwrap: caller contract guarantees k <= nums.count, so the
        // heap is non-empty here.
        return heap.peek()!
    }
}

/// A small array-backed min-heap of `Int`. Scoped to this file so the answer
/// stays self-contained; the project's `MinHeap` could be used instead.
private struct MinIntHeap {
    private var data: [Int] = []

    var count: Int { data.count }

    func peek() -> Int? { data.first }

    mutating func push(_ value: Int) {
        data.append(value)
        siftUp(from: data.count - 1)
    }

    mutating func pop() -> Int? {
        guard !data.isEmpty else { return nil }
        data.swapAt(0, data.count - 1)
        let popped = data.removeLast()
        if !data.isEmpty { siftDown(from: 0) }
        return popped
    }

    private mutating func siftUp(from index: Int) {
        var i = index
        while i > 0 {
            let parent = (i - 1) / 2
            guard data[i] < data[parent] else { return }
            data.swapAt(i, parent)
            i = parent
        }
    }

    private mutating func siftDown(from index: Int) {
        var i = index
        let n = data.count
        while true {
            let left = 2 * i + 1
            let right = 2 * i + 2
            var smallest = i
            if left < n, data[left] < data[smallest] { smallest = left }
            if right < n, data[right] < data[smallest] { smallest = right }
            if smallest == i { return }
            data.swapAt(i, smallest)
            i = smallest
        }
    }
}
