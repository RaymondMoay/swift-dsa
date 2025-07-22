//
//  StackTests.swift
//  SwiftDSA
//
//  Created by Ray on 18/6/25.
//

import Testing

@testable import SwiftDSA

struct StackTests {
    
    @Test
    func testStackBasicOperations() async throws {
        let stack = Stack<Int>()

        // Initially the stack should be empty
        #expect(stack.length == 0)
        #expect(stack.peek(item: 0) == nil)
        #expect(stack.pop(item: 0) == nil)

        // Push one item
        stack.push(item: 10)
        #expect(stack.length == 1)
        #expect(stack.peek(item: 0) == 10)

        // Push more items
        stack.push(item: 20)
        stack.push(item: 30)
        #expect(stack.length == 3)
        #expect(stack.peek(item: 0) == 30) // LIFO, top should be 30

        // Pop items and check order (LIFO)
        let first = stack.pop(item: 0)
        #expect(first == 30)
        #expect(stack.length == 2)

        let second = stack.pop(item: 0)
        #expect(second == 20)
        #expect(stack.length == 1)

        let third = stack.pop(item: 0)
        #expect(third == 10)
        #expect(stack.length == 0)

        // The stack should now be empty again
        #expect(stack.peek(item: 0) == nil)
        #expect(stack.pop(item: 0) == nil)
    }
}
