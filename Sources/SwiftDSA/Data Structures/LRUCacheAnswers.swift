//
//  LRUCache.swift
//  SwiftDSA
//
//  Created by Ray on 3/7/25.
//

final class LRUCacheAnswers<Key: Hashable, Value: Hashable> {
    
    let capacity: Int
    var length: Int
    var head: Node<Value>?
    var tail: Node<Value>?
    var storage: [Key: Node<Value>] = [:]
    var reverseStorage: [Node<Value>: Key] = [:]
    
    init(capacity: Int) {
        self.capacity = capacity
        self.length = 0
    }
    
    func update(key: Key, value: Value) {
        guard let node = storage[key] else {
            if length >= capacity {
                trimCache()
            }
            let newNode = Node(value: value)
            length += 1
            
            prepend(node: newNode)
            storage[key] = newNode
            reverseStorage[newNode] = key
            return
        }
        
        node.value = value
        detach(node: node)
        prepend(node: node)
    }
    
    func get(key: Key) -> Value? {
        guard let node = storage[key] else { return nil }
        detach(node: node)
        prepend(node: node)
        return node.value
    }
    
    // helpers
    
    /// detach and prepend should NOT handle length
    
    func detach(node: Node<Value>) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        if self.head == node {
            self.head = node.next
        }
        
        if self.tail == node {
            self.tail = node.prev
        }
        
        node.next = nil
        node.prev = nil
    }
    
    func prepend(node: Node<Value>) {
        head?.prev = node
        node.next = head
        head = node
        
        // housekeeping
        if length == 1 {
            tail = head
        }
    }
    
    // housekeeping
    func trimCache() {
        guard length >= capacity, let tail else { return }
        
        if length == 1 {
            self.tail = nil
            self.head = nil
        } else {
            tail.prev?.next = nil
            self.tail = tail.prev
        }
        
        // housekeeping
        self.length -= 1
        
        guard let key = reverseStorage[tail] else {
            assertionFailure("You did not store keys when creating it!!")
            return
        }
        storage[key] = nil
        reverseStorage[tail] = nil
    }
}
