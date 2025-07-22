//
//  BFSTests.swift
//  SwiftDSA
//
//  Created by Ray on 22/6/25.
//

import Testing

@testable import SwiftDSA

struct BFSTests {
    
    @Test func assertArrayPerform() async throws {
        let root = createRoot()
        
        #expect(BFS.performArray(head: root, needle: 1) == true)
        #expect(BFS.performArray(head: root, needle: 5) == true)
        #expect(BFS.performArray(head: root, needle: 13) == true)
        #expect(BFS.performArray(head: root, needle: 7) == true)
        #expect(BFS.performArray(head: root, needle: 29) == false)
    }
    
    @Test func assertQueuePerform() async throws {
        let root = createRoot()
        
        #expect(BFS.performQueue(head: root, needle: 1) == true)
        #expect(BFS.performQueue(head: root, needle: 5) == true)
        #expect(BFS.performQueue(head: root, needle: 13) == true)
        #expect(BFS.performQueue(head: root, needle: 7) == true)
        #expect(BFS.performQueue(head: root, needle: 29) == false)
    }
}

// MARK: Helper

extension BFSTests {
    
    func createRoot() -> BinaryNode<Int> {
        
        // level 3
        let n12 = BinaryNode(value: 12, left: nil, right: nil)
        let n17 = BinaryNode(value: 17, left: nil, right: nil)
        let n21 = BinaryNode(value: 21, left: nil, right: nil)
        let n1 = BinaryNode(value: 1, left: nil, right: nil)
        
        // level 2
        let n5 = BinaryNode(value: 5, left: n12, right: n17)
        let n13 = BinaryNode(value: 13, left: n21, right: n1)
        
        // level 1
        let root = BinaryNode(value: 7, left: n5, right: n13)
        
        return root
    }
}
