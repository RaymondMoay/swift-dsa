//
//  BFSAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 23/6/25.
//

struct BFSAnswers {
    
    /// We want to make sure to use a Queue in general, because we are shifting, which is O(N) in an array, and we have to do that, theoretically, N times, so it makes BFS a O(N^2).
    ///
    /// If we use a queue, it will be pretty much O(n), because enqueue and deque is O(1). We don't really need the O(1) indexing feature of an array here!
    ///
    /// In Bulletin, checking if a child TaskItem has a tag, i.e. `childHasTag()` benefits from BFS (if we have a usecase with more breadth instead of depth), uses BFS with a QUEUE instead of an ARRAY for performance. (users can have a lot of nested children).
    static func performArray(head: BinaryNode<Int>, needle: Int) -> Bool {
        
        var queue: [BinaryNode<Int>] = [head]
        
        while queue.isEmpty == false {
            
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
            let curr = queue.deque()
            if curr?.value == needle {
                return true
            }
            
            if let left = curr?.left {
                queue.enqueue(item: left)
            }
            
            if let right = curr?.right {
                queue.enqueue(item: right)
            }
        }
        
        return false
    }
}
