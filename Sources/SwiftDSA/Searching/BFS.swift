//
//  BFS.swift
//  SwiftDSA
//
//  Created by Ray on 22/6/25.
//

struct BFS {
    
    static func performArray(head: BinaryNode<Int>, needle: Int) -> Bool {
        var queue = [head]
        
        while (queue.isEmpty == false) {
            let curr = queue.removeFirst()
            
            if curr.value == needle {
                return true
            }
            
            if let left = curr.left {
                queue.append(left)
            }
            
            if let right = curr.right {
                queue.append(right)
            }
        }
        
        return false
    }
    
    static func performQueue(head: BinaryNode<Int>, needle: Int) -> Bool {
        let queue = Queue<BinaryNode<Int>>()
        queue.enqueue(item: head)
        
        while queue.length > 0 {
            let curr = queue.deque()!
            
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
