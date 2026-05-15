//
//  MergeKSortedLists.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//
//  LC 23 — Merge K Sorted Lists
//
//  You are given an array of k linked-lists, each sorted in ascending order.
//  Merge all the linked-lists into a single sorted linked-list and return it.
//
//  Example:
//    Input:  [[1,4,5],[1,3,4],[2,6]]
//    Output: 1 → 1 → 2 → 3 → 4 → 4 → 5 → 6
//
//  Constraints:
//    - 0 <= k <= 10^4
//    - 0 <= lists[i].count <= 500
//    - -10^4 <= node.value <= 10^4
//    - Each list is sorted in ascending order.
//    - The total number of nodes across all lists is at most 10^4.
//
//  Hints:
//    - The naive approach concatenates everything and sorts: O(N log N).
//      You can do better — exploit the fact that each list is *already sorted*.
//    - Pairwise merge using two-pointer merge: O(N log K).
//    - Heap approach: push the head of every list into a min-heap. Repeatedly
//      pop the smallest, append it to the result, and push its `.next` if it
//      exists. Also O(N log K). This is the canonical interview answer.
//
//  Target:
//    Time:  O(N log K) where N = total nodes, K = number of lists.
//    Space: O(K) for the heap.
//
//  Why this models a real payments problem:
//    Merging paginated transaction feeds from multiple sources (card,
//    bank-transfer, PayNow, refund channel) — each feed is already
//    ordered by timestamp; the client must present one merged stream.
//    A min-heap over the head of each feed is exactly the right shape.
//
//  Interviewer hint (concept check):
//    Be ready to explain why K matters more than N in the heap's log factor —
//    the heap is only ever bounded by the number of *lists*, not by the total
//    node count, because each list contributes one element to the heap at a
//    time.
//
//  Note on `ListNode`:
//    Defined below as a small local class so the problem is self-contained.
//    Use `==` only via reference identity for tests if needed; equality of
//    *values* is what we assert in the test file.

/// Singly-linked list node used by this problem only.
final class ListNode {
    var value: Int
    var next: ListNode?

    init(_ value: Int, _ next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

struct MergeKSortedLists {

    /// Merges `lists` (each sorted ascending) into a single sorted list and
    /// returns its head.
    static func merge(_ lists: [ListNode?]) -> ListNode? {
        // TODO: your answer here
        return nil
    }
}

// MARK: - Convenience helpers for tests

extension ListNode {
    /// Builds a list from an array of values. Returns nil if `values` is empty.
    static func from(_ values: [Int]) -> ListNode? {
        guard let first = values.first else { return nil }
        let head = ListNode(first)
        var tail = head
        for v in values.dropFirst() {
            let node = ListNode(v)
            tail.next = node
            tail = node
        }
        return head
    }

    /// Flattens this list into an array of values for easy assertions.
    func toArray() -> [Int] {
        var out: [Int] = []
        var node: ListNode? = self
        while let n = node {
            out.append(n.value)
            node = n.next
        }
        return out
    }
}
