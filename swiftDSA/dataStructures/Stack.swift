//
//  Stack.swift
//  swiftDSA
//
//  Created by Raymond Moay on 29/8/23.
//

import Foundation

struct Stack<T> {
    var length: Int
    var head: Node<T>?
    
    mutating func push(val: T) {
        let node = Node(value: val)
        
        self.length += 1
        
        guard let head = head else {
            head = node
            return
        }
        
        node.prev = head
        self.head = node
    }
    
    mutating func pop() -> T? {
        guard let head = head else {
            return nil
        }
        
        self.length -= 1
        self.head = head.prev
        return head.value
    }
    
    func peek() -> T? {
        return head?.value
    }
}
