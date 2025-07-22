//
//  QueueTests.swift
//  SwiftDSA
//
//  Created by Ray on 18/6/25.
//

import Testing

@testable import SwiftDSA

struct QueueTests {
    
    @Test
    func testQueueBasicOperations() async throws {
        let queue = Queue<Int>()

        // Initially the queue should be empty
        #expect(queue.length == 0)
        #expect(queue.peek() == nil)
        #expect(queue.deque() == nil)

        // Enqueue one item
        queue.enqueue(item: 1)
        #expect(queue.length == 1)
        #expect(queue.peek() == 1)

        // Enqueue more items
        queue.enqueue(item: 2)
        queue.enqueue(item: 3)
        #expect(queue.length == 3)
        #expect(queue.peek() == 1) // Front should still be the first item

        // Dequeue items and check order (FIFO)
        let first = queue.deque()
        #expect(first == 1)
        #expect(queue.length == 2)

        let second = queue.deque()
        #expect(second == 2)
        #expect(queue.length == 1)

        let third = queue.deque()
        #expect(third == 3)
        #expect(queue.length == 0)

        // The queue should now be empty again
        #expect(queue.peek() == nil)
        #expect(queue.deque() == nil)
    }
}
