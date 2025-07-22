//
//  Stack.swift
//  SwiftDSA
//
//  Created by Ray on 18/6/25.
//

// 1(t) < 2 < 3 < 4 < 5 < 6(h)
///
/// LIFO
class Stack<T> {
    
    var length: Int
    var head: Node?
    // no tail, as we rarely care about tails in LIFo
    
    init(length: Int = 0, head: Node? = nil) {
        self.length = length
        self.head = head
    }
    
    func push(item: T) {
        let node = Node(value: item, prev: self.head)
        self.head = node
        self.length += 1
    }
    
    func pop(item: T) -> T? {
        guard let head else { return nil }
        let prev = head.prev
        let poppedHead = head
        self.head = prev // prev is nullable, meaning if only 1 item, it will automatically set head to undefined.
        self.length -= 1
        return poppedHead.value
    }
    
    func peek(item: T) -> T? {
        guard let head else { return nil }
        return head.value
    }
}

extension Stack {
    
    class Node {
        
        var value: T
        var prev: Node? // prev is easier to think about when it comes to Stacks
        
        init(value: T, prev: Node? = nil) {
            self.value = value
            self.prev = prev
        }
    }
}
