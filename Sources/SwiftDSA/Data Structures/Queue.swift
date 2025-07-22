//
//  Queue.swift
//  SwiftDSA
//
//  Created by Ray on 18/6/25.
//


/// 1(h) > 2 > 3 > 4 > 5 > 6(t)
///
/// FIFO
class Queue<T> {
    
    var length: Int
    var head: Node<T>?
    var tail: Node<T>?
    
    init(length: Int = 0, head: Node<T>? = nil,  tail: Node<T>? = nil) {
        self.length = length
        self.head = head
        self.tail = tail
    }
    
    func enqueue(item: T) {
        let node = Node(value: item)
        if let _ = tail {
            self.tail?.next = node
            self.tail = node
        } else {
            self.head = node
            self.tail = node
        }
        self.length += 1
    }
    
    func deque() -> T? {
        guard let head else { return nil }
        self.length -= 1
        
        let dequedHead = head
        self.head = head.next
        if self.head == nil {
            self.tail = nil
        }
        return dequedHead.value
    }
    
    func peek() -> T? {
        self.head?.value
    }
}

extension Queue {
    
    class Node<V> {
        var value: V
        var next: Node<V>?
        
        init(value: V, next: Node<V>? = nil) {
            self.value = value
            self.next = next
        }
    }
}
