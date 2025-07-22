//
//  CompareBinaryTreeTests.swift
//  SwiftDSA
//
//  Created by Ray on 23/6/25.
//

import Testing

@testable import SwiftDSA

struct CompareBinaryTreeTests {
    
    @Test func assert() async throws {
        #expect(CompareBinaryTree.perform(headA: createRootA(), headB: createRootB()) == false)
        #expect(CompareBinaryTree.perform(headA: createRootA(), headB: createRootA()) == true)
        #expect(CompareBinaryTree.perform(headA: createRootB(), headB: createRootB()) == true)
    }
}

// MARK: Helper

extension CompareBinaryTreeTests {
    
    func createRootA() -> BinaryNode<Int> {
        
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
    
    func createRootB() -> BinaryNode<Int> {
        
        // level 3
        let n12 = BinaryNode(value: 12, left: nil, right: nil)
        let n17 = BinaryNode(value: 4, left: nil, right: nil)
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
