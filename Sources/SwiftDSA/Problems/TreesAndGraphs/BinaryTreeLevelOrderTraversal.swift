//
//  BinaryTreeLevelOrderTraversal.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 102 — Binary Tree Level Order Traversal
//
//  Given the root of a binary tree, return the level order traversal of its
//  nodes' values (i.e. from left to right, level by level).
//
//  Example:
//        3
//       / \
//      9  20
//         / \
//        15  7
//
//    -> [[3], [9, 20], [15, 7]]
//
//    nil  -> []
//
//  Constraints:
//    The number of nodes in the tree is in the range [0, 2000].
//    -1000 <= Node.val <= 1000
//
//  Target: O(n) time, O(n) space (queue + output).

struct BinaryTreeLevelOrderTraversal {

    static func perform(_ root: BinaryNode<Int>?) -> [[Int]] {
        
        guard let root else { return [] }
        
        var result: [[Int]] = []
        
        let q = Queue<BinaryNode<Int>>()
        q.enqueue(item: root)
        
        while q.length > 0 {
            let level = q.length
            var arr: [Int] = []
            arr.reserveCapacity(level)
            
            for _ in 0..<level {
                let curr = q.deque()!
                arr.append(curr.value)
                if let left = curr.left {
                    q.enqueue(item: left)
                }
                if let right = curr.right {
                    q.enqueue(item: right)
                }
            }
            result.append(arr)
        }
        
        return result
    }
}
