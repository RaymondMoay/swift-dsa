//
//  MergeKSortedListsAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

/// Reference implementation of LC 23 — Merge K Sorted Lists.
///
/// Strategy: min-heap keyed on `value`. Push the head of each non-empty list,
/// then repeatedly pop the smallest, append it to the output, and push its
/// `.next` if any.
///
/// Time:  O(N log K) — each of N nodes is pushed and popped once; heap size
///        is bounded by K (the number of lists).
/// Space: O(K) for the heap. The output reuses input nodes — no extra
///        allocation for node payloads.
struct MergeKSortedListsAnswer {

    static func merge(_ lists: [ListNode?]) -> ListNode? {
        var heap = MinNodeHeap()
        for head in lists {
            if let head { heap.push(head) }
        }

        let sentinel = ListNode(0)
        var tail = sentinel

        while let smallest = heap.pop() {
            tail.next = smallest
            tail = smallest
            if let next = smallest.next {
                heap.push(next)
            }
        }
        // Detach the last node from any stale `.next` is unnecessary — every
        // popped node was either re-pushed via its `.next` or was the tail of
        // its source list (`.next == nil`). Either way `tail.next` is correct.

        return sentinel.next
    }
}

/// Min-heap of `ListNode` keyed on `value`. Scoped to this file.
private struct MinNodeHeap {
    private var data: [ListNode] = []

    var isEmpty: Bool { data.isEmpty }

    mutating func push(_ node: ListNode) {
        data.append(node)
        siftUp(from: data.count - 1)
    }

    mutating func pop() -> ListNode? {
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
            guard data[i].value < data[parent].value else { return }
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
            if left < n, data[left].value < data[smallest].value { smallest = left }
            if right < n, data[right].value < data[smallest].value { smallest = right }
            if smallest == i { return }
            data.swapAt(i, smallest)
            i = smallest
        }
    }
}
