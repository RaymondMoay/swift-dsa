//
//  TopKFrequentElementsAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 347 — Top K Frequent Elements.
///
/// Strategy:
///   1. Build a frequency dictionary in O(n).
///   2. Maintain a min-heap of size k keyed on frequency. Push each
///      `(count, num)` entry; whenever the heap grows past k, pop the min.
///   3. The heap's payload is the answer.
///
/// Time:  O(n log k)
/// Space: O(n) — frequency dictionary dominates.
struct TopKFrequentElementsAnswer {

    static func find(_ nums: [Int], k: Int) -> [Int] {
        var counts: [Int: Int] = [:]
        for n in nums { counts[n, default: 0] += 1 }

        var heap = MinFreqHeap()
        for (num, count) in counts {
            heap.push(count: count, num: num)
            if heap.size > k { _ = heap.pop() }
        }

        return heap.values()
    }
}

/// Min-heap of `(count, num)` ordered by `count`. Scoped to this file.
private struct MinFreqHeap {
    private var data: [(count: Int, num: Int)] = []

    var size: Int { data.count }

    mutating func push(count: Int, num: Int) {
        data.append((count, num))
        siftUp(from: data.count - 1)
    }

    @discardableResult
    mutating func pop() -> (count: Int, num: Int)? {
        guard !data.isEmpty else { return nil }
        data.swapAt(0, data.count - 1)
        let popped = data.removeLast()
        if !data.isEmpty { siftDown(from: 0) }
        return popped
    }

    func values() -> [Int] { data.map(\.num) }

    private mutating func siftUp(from index: Int) {
        var i = index
        while i > 0 {
            let parent = (i - 1) / 2
            guard data[i].count < data[parent].count else { return }
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
            if left < n, data[left].count < data[smallest].count { smallest = left }
            if right < n, data[right].count < data[smallest].count { smallest = right }
            if smallest == i { return }
            data.swapAt(i, smallest)
            i = smallest
        }
    }
}
