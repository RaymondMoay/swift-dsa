//
//  MergeSortedSinglyLinkedList.swift
//  SwiftDSA
//
//  Created by Ray on 25/6/25.
//

struct MergeSortedSinglyLinkedList {
    
    /// 1. Trav through root A
    /// 2. For each node, get range of values to insert, curr.value -> next.value (Recursive fn 1: Traverse node A)
    ///     - if next.value == nil, let lo = curr.val, hi = nil
    ///     - if next.value = curr.value, traverse
    ///     - if next.value > curr.value, let lo = curr.val, hi = curr.next.val
    /// 3. Given lo and hi, trav through node b to split root B and merge into rootA (Recursive fn 2: Traverse node B given lo and hi)
    ///     - if next.value
    static func perform(rootA: Node<Int>, rootB: Node<Int>) {
        
        // recursion 1
        func getTail(curr: Node<Int>?, hi: Int) -> Node<Int>? {
            // base case
            guard let curr else { return nil } // no tail
            
            // 1. if hi is smaller, no tail, move on
            if hi < curr.value {
                return nil
            }
            
            // 2. if inserting node is last, it is the tail
            guard let next = curr.next else { return curr }
            
            // 3. if next is larger than hi, then curr is tail
            if next.value > hi {
                return curr
            }
            
            // recurse
            return getTail(curr: curr.next, hi: hi)
        }
        
        // recursion 2
        func walk(curr: Node<Int>?, insertingNode: Node<Int>?) {
            // base case
            
            // 1. are there any more inserting node?
            guard let insertingNode, let curr else { return }
            
            // 2. are you already larger than 
            
            
            // recurse
            // if next is empty, just merge it!
            guard let next = curr.next else {
                curr.next = insertingNode
                return
            }
            
            if curr.value == next.value {
                walk(curr: next, insertingNode: insertingNode)
            } else if curr.value < next.value {
                let hi = next.value
                guard let tail = getTail(curr: insertingNode, hi: hi) else {
                    /// no tail, when inserting node is nil, 
                    walk(curr: next, insertingNode: insertingNode)
                    return
                }
                
                if tail.value < curr.value {
                    tail.next = curr
                    return
                }
                
                curr.next = insertingNode
                let remaindingInsertingNode = tail.next
                tail.next = next
                walk(curr: next, insertingNode: remaindingInsertingNode)
            }
        }
        
        walk(curr: rootA, insertingNode: rootB)
    }
}
