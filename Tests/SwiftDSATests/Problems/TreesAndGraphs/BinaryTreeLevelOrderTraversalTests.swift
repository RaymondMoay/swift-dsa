//
//  BinaryTreeLevelOrderTraversalTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct BinaryTreeLevelOrderTraversalTests {

    private func leaf(_ v: Int) -> BinaryNode<Int> {
        BinaryNode(value: v, left: nil, right: nil)
    }

    @Test func emptyTree() async throws {
        #expect(BinaryTreeLevelOrderTraversal.perform(nil) == [])
    }

    @Test func singleNode() async throws {
        let root = leaf(1)
        #expect(BinaryTreeLevelOrderTraversal.perform(root) == [[1]])
    }

    @Test func canonicalThreeLevels() async throws {
        //        3
        //       / \
        //      9  20
        //         / \
        //        15  7
        let twenty = BinaryNode(value: 20, left: leaf(15), right: leaf(7))
        let root = BinaryNode(value: 3, left: leaf(9), right: twenty)
        #expect(BinaryTreeLevelOrderTraversal.perform(root) == [[3], [9, 20], [15, 7]])
    }

    @Test func leftSkewed() async throws {
        //  1
        //  |
        //  2
        //  |
        //  3
        let three = leaf(3)
        let two   = BinaryNode(value: 2, left: three, right: nil)
        let one   = BinaryNode(value: 1, left: two,   right: nil)
        #expect(BinaryTreeLevelOrderTraversal.perform(one) == [[1], [2], [3]])
    }

    @Test func rightSkewed() async throws {
        let three = leaf(3)
        let two   = BinaryNode(value: 2, left: nil, right: three)
        let one   = BinaryNode(value: 1, left: nil, right: two)
        #expect(BinaryTreeLevelOrderTraversal.perform(one) == [[1], [2], [3]])
    }

    @Test func asymmetricLevels() async throws {
        //         1
        //        / \
        //       2   3
        //      /     \
        //     4       5
        let two = BinaryNode(value: 2, left: leaf(4), right: nil)
        let three = BinaryNode(value: 3, left: nil, right: leaf(5))
        let one = BinaryNode(value: 1, left: two, right: three)
        #expect(BinaryTreeLevelOrderTraversal.perform(one) == [[1], [2, 3], [4, 5]])
    }
}
