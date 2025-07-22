//
//  DFSTreeSearch.swift
//  SwiftDSA
//
//  Created by Ray on 22/6/25.
//

import Testing

@testable import SwiftDSA

struct DFSTests {
    
    @Test
    func assertPreOrderTraversal() {
        let root = createRoot()
        #expect(DFS.Traversal.performPreOrder(head: root) == [7, 5, 12, 17, 13, 21, 1])
    }
    
    @Test
    func assertInOrderTraversal() {
        let root = createRoot()
        #expect(DFS.Traversal.performInOrder(head: root) == [12, 5, 17, 7, 21, 13, 1])
    }
    
    @Test
    func assertPostOrderTraversal() {
        let root = createRoot()
        #expect(DFS.Traversal.performPostOrder(head: root) == [12, 17, 5, 21, 1, 13, 7])
    }
    
    @Test
    func assertPreOrderSearch() {
        let root = createRoot()
        #expect(DFS.Search.performPreorder(head: root, needle: 1) == true)
        #expect(DFS.Search.performPreorder(head: root, needle: 17) == true)
        #expect(DFS.Search.performPreorder(head: root, needle: 13) == true)
        #expect(DFS.Search.performPreorder(head: root, needle: 5) == true)
        #expect(DFS.Search.performPreorder(head: root, needle: 7) == true)
        #expect(DFS.Search.performPreorder(head: root, needle: 29) == false)
    }
    
    @Test
    func assertInOrderSearch() {
        let root = createRoot()
        #expect(DFS.Search.performInorder(head: root, needle: 1) == true)
        #expect(DFS.Search.performInorder(head: root, needle: 17) == true)
        #expect(DFS.Search.performInorder(head: root, needle: 13) == true)
        #expect(DFS.Search.performInorder(head: root, needle: 5) == true)
        #expect(DFS.Search.performInorder(head: root, needle: 7) == true)
        #expect(DFS.Search.performInorder(head: root, needle: 29) == false)
    }
    
    @Test
    func assertPostOrderSearch() {
        let root = createRoot()
        #expect(DFS.Search.performPostorder(head: root, needle: 1) == true)
        #expect(DFS.Search.performPostorder(head: root, needle: 17) == true)
        #expect(DFS.Search.performPostorder(head: root, needle: 13) == true)
        #expect(DFS.Search.performPostorder(head: root, needle: 5) == true)
        #expect(DFS.Search.performPostorder(head: root, needle: 7) == true)
        #expect(DFS.Search.performPostorder(head: root, needle: 29) == false)
    }
    
    @Test
    func assertBinarySearchTree() async throws {
        let root = createBinarySearchTree()
        #expect(DFS.BinarySearch.perform(head: root, needle: 19) == true)
        #expect(DFS.BinarySearch.perform(head: root, needle: 18) == true)
        #expect(DFS.BinarySearch.perform(head: root, needle: 25) == true)
        #expect(DFS.BinarySearch.perform(head: root, needle: 7) == true)
        #expect(DFS.BinarySearch.perform(head: root, needle: 16) == true)
        #expect(DFS.BinarySearch.perform(head: root, needle: 100) == false)
    }
}

// MARK: Helper

extension DFSTests {
    
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
    
    func createBinarySearchTree() -> BinaryNode<Int> {
        
        return .init(value: 17,
                     left: .init(value: 15,
                                 left: .init(value: 7,
                                             left: nil,
                                             right: nil),
                                 right: .init(value: 16,
                                              left: nil,
                                              right: nil)),
                     right: .init(value: 25,
                                  left: .init(value: 19,
                                              left: .init(value: 18,
                                                          left: nil,
                                                          right: nil),
                                              right: .init(value: 23,
                                                           left: nil,
                                                           right: nil)),
                                  right: nil))
    }
}
