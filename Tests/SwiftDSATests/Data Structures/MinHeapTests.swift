//
//  MinHeapTests.swift
//  SwiftDSA
//
//  Created by Ray on 24/6/25.
//

import Testing

@testable import SwiftDSA

struct MinHeapTests {
    
    @Test
    func assertMinHeap() async throws {
        let heap = MinHeap()
        
        #expect(heap.length == 0)
        
        heap.insert(value: 5)
        heap.insert(value: 3)
        heap.insert(value: 69)
        heap.insert(value: 420)
        heap.insert(value: 4)
        heap.insert(value: 1)
        heap.insert(value: 8)
        heap.insert(value: 7)
        
        #expect(heap.length == 8)
        #expect(heap.delete() == 1)
        #expect(heap.delete() == 3)
        #expect(heap.delete() == 4)
        #expect(heap.delete() == 5)
        #expect(heap.length == 4)
        #expect(heap.delete() == 7)
        #expect(heap.delete() == 8)
        #expect(heap.delete() == 69)
        #expect(heap.delete() == 420)
        #expect(heap.length == 0)
    }
}
