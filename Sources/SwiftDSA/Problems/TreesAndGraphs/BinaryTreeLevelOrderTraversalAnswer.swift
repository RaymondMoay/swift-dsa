//
//  BinaryTreeLevelOrderTraversalAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct BinaryTreeLevelOrderTraversalAnswer {

    /// BFS, processing one level at a time.
    ///
    /// At the start of each iteration the queue contains exactly the nodes of
    /// the next level. We snapshot its `count`, pop that many nodes into the
    /// current level's array, and enqueue their children for the next level.
    ///
    /// Time:  O(n) — each node is enqueued and dequeued once.
    /// Space: O(n) — queue holds at most one full level (up to n/2 leaves).
    static func perform(_ root: BinaryNode<Int>?) -> [[Int]] {
        guard let root else { return [] }

        var result: [[Int]] = []
        var queue: [BinaryNode<Int>] = [root]

        while !queue.isEmpty {
            let levelSize = queue.count
            var level: [Int] = []
            level.reserveCapacity(levelSize)

            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                level.append(node.value)
                if let l = node.left  { queue.append(l) }
                if let r = node.right { queue.append(r) }
            }

            result.append(level)
        }

        return result
    }
}
