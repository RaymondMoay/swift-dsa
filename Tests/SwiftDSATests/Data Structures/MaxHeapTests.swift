//
//  MaxHeapTests.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

import Testing

@testable import SwiftDSA

struct MaxHeapTests {

    // Always start from an empty heap and build via enqueue,
    // since the init does not heapify a pre-loaded array.
    private func makeHeap(_ values: [Int] = []) -> MaxHeap {
        let heap = MaxHeap(length: 0, data: [])
        for v in values { heap.enqueue(v) }
        return heap
    }

    private func drain(_ heap: MaxHeap) -> [Int] {
        var out: [Int] = []
        while let v = heap.dequeue() { out.append(v) }
        return out
    }

    @Test
    func emptyHeap() async throws {
        let heap = makeHeap()
        #expect(heap.length == 0)
        #expect(heap.dequeue() == nil)
        #expect(heap.length == 0)
    }

    @Test
    func singleElement() async throws {
        let heap = makeHeap([42])
        #expect(heap.length == 1)
        #expect(heap.dequeue() == 42)
        #expect(heap.length == 0)
        #expect(heap.dequeue() == nil)
    }

    @Test
    func twoElements() async throws {
        let heap = makeHeap([1, 2])
        #expect(heap.dequeue() == 2)
        #expect(heap.dequeue() == 1)
        #expect(heap.dequeue() == nil)
    }

    // After popping the root of a 3-element heap, the remaining subtree
    // has a parent with only a left child. A correct heapifyDown must
    // not read the missing right index.
    @Test
    func partialLastLevelOnlyLeftChild() async throws {
        let heap = makeHeap([5, 3, 4])
        #expect(heap.dequeue() == 5)
        #expect(heap.dequeue() == 4)
        #expect(heap.dequeue() == 3)
        #expect(heap.dequeue() == nil)
    }

    @Test
    func ascendingInsertOrder() async throws {
        let heap = makeHeap([1, 2, 3, 4, 5, 6, 7, 8])
        #expect(heap.length == 8)
        #expect(drain(heap) == [8, 7, 6, 5, 4, 3, 2, 1])
        #expect(heap.length == 0)
    }

    @Test
    func descendingInsertOrder() async throws {
        let heap = makeHeap([8, 7, 6, 5, 4, 3, 2, 1])
        #expect(drain(heap) == [8, 7, 6, 5, 4, 3, 2, 1])
    }

    @Test
    func unsortedInsertOrder() async throws {
        let heap = makeHeap([5, 3, 69, 420, 4, 1, 8, 7])
        #expect(heap.length == 8)
        #expect(drain(heap) == [420, 69, 8, 7, 5, 4, 3, 1])
    }

    @Test
    func duplicatesPreservedAsMultiset() async throws {
        let heap = makeHeap([3, 3, 3, 1, 2, 2, 5, 5])
        #expect(drain(heap) == [5, 5, 3, 3, 3, 2, 2, 1])
    }

    @Test
    func allEqualValues() async throws {
        let heap = makeHeap([7, 7, 7, 7, 7])
        #expect(drain(heap) == [7, 7, 7, 7, 7])
    }

    // Targets a common heapifyDown bug: when the two children are equal
    // but the parent is smaller, naive `left > right` / `right > left`
    // checks both fail and no swap happens, corrupting the heap.
    @Test
    func equalChildrenWithSmallerParent() async throws {
        let heap = makeHeap([5, 5, 5, 3])
        #expect(heap.dequeue() == 5)
        #expect(heap.dequeue() == 5)
        #expect(heap.dequeue() == 5)
        #expect(heap.dequeue() == 3)
    }

    @Test
    func negativeAndPositiveValues() async throws {
        let heap = makeHeap([-3, -1, -10, 5, 0, 2, -7])
        #expect(drain(heap) == [5, 2, 0, -1, -3, -7, -10])
    }

    @Test
    func interleavedEnqueueAndDequeue() async throws {
        let heap = makeHeap()
        heap.enqueue(5)
        heap.enqueue(3)
        #expect(heap.dequeue() == 5)
        heap.enqueue(10)
        heap.enqueue(1)
        #expect(heap.dequeue() == 10)
        #expect(heap.dequeue() == 3)
        heap.enqueue(7)
        #expect(heap.dequeue() == 7)
        #expect(heap.dequeue() == 1)
        #expect(heap.dequeue() == nil)
    }

    @Test
    func lengthTracksAcrossOperations() async throws {
        let heap = makeHeap()
        #expect(heap.length == 0)
        heap.enqueue(1); #expect(heap.length == 1)
        heap.enqueue(2); #expect(heap.length == 2)
        heap.enqueue(3); #expect(heap.length == 3)
        _ = heap.dequeue(); #expect(heap.length == 2)
        _ = heap.dequeue(); #expect(heap.length == 1)
        heap.enqueue(99); #expect(heap.length == 2)
        _ = heap.dequeue(); #expect(heap.length == 1)
        _ = heap.dequeue(); #expect(heap.length == 0)
        _ = heap.dequeue(); #expect(heap.length == 0)
    }

    @Test
    func reusableAfterFullDrain() async throws {
        let heap = makeHeap([4, 2, 6, 1])
        _ = drain(heap)
        #expect(heap.length == 0)
        heap.enqueue(100)
        heap.enqueue(50)
        #expect(heap.dequeue() == 100)
        #expect(heap.dequeue() == 50)
        #expect(heap.dequeue() == nil)
    }

    // Strongest correctness check: dequeue order must equal the input
    // sorted in descending order, for any input.
    @Test
    func largeRandomBatchMatchesSortedDescending() async throws {
        var rng = SystemRandomNumberGenerator()
        let input = (0..<200).map { _ in Int.random(in: -1000...1000, using: &rng) }
        let heap = makeHeap(input)
        #expect(heap.length == input.count)
        #expect(drain(heap) == input.sorted(by: >))
    }
}
