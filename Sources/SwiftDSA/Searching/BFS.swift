//
//  BFS.swift
//  SwiftDSA
//
//  Created by Ray on 22/6/25.
//

struct BFS {
    
    static func performArray(head: BinaryNode<Int>, needle: Int) -> Bool {
        var queue = [head]
        var idx = 0 // more performant with an index pointer, supercedes the O(N) from an arrayList
        
        while queue.count - idx > 0 {
            let node = queue[idx]
            
            if node.value == needle {
                return true
            }
            
            idx += 1
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        
        return false
    }
    
    static func performQueue(head: BinaryNode<Int>, needle: Int) -> Bool {
        let queue = Queue<BinaryNode<Int>>()
        queue.enqueue(item: head)
        
        while queue.length > 0 {
            guard let curr = queue.deque() else { return false }
            
            if curr.value == needle {
                return true
            }
            
            if let left = curr.left {
                queue.enqueue(item: left)
            }
            if let right = curr.right {
                queue.enqueue(item: right)
            }
        }
        
        return false
    }
}
