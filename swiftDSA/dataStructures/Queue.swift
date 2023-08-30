//
//  Queue.swift
//  swiftDSA
//
//  Created by Raymond Moay on 27/8/23.
//

import Foundation

struct Queue<T> {
    var length: Int
    var head: Node<T>? // this is a class, so it is pass by reference
    var tail: Node<T>?
    
    mutating func enqueue(val: T) {
        let newNode = Node(value: val)
        length += 1
        guard let tail = tail else {
            self.tail = newNode
            self.head = newNode
            return
        }
        
        tail.next = newNode
        self.tail = newNode
    }
    
    mutating func dequeue() -> T? {
        guard let head = head else {
            return nil
        }
        
        length -= 1
        
        self.head = head.next
        return head.value
    }
    
    mutating func peek() -> T? {
        return self.head?.value ?? nil
    }
}
