//
//  LRUCache.swift
//  SwiftDSA
//
//  Created by Ray on 3/7/25.
//

final class LRUCache<Key: Hashable, Value: Hashable> {
    
    private let capacity: Int
    private var length: Int
    private var head: Node<Value>?
    private var tail: Node<Value>?
    
    private var lookup: [Key: Node<Value>] = [:]
    private var reverseLookup: [Node<Value>: Key] = [:]
    
    init(capacity: Int) {
        self.capacity = capacity
        self.length = 0
        self.head = nil
        self.tail = nil
    }
    
    /// Insertion, and an update. Insert if key does not exist.
    func update(key: Key, value: Value) {
        
        // does it exist?
        guard let node = lookup[key] else {
            
            let newNode = Node(value: value)
            
            // adjust length
            length += 1
            prepend(node: newNode)
            trimCache()
            
            lookup[key] = newNode
            reverseLookup[newNode] = key
            
            return
        }
        
        // it does exist
        
        detach(node: node)
        prepend(node: node)
        node.value = value
        
        /// if key does not exist, insert at head.
        ///     if capacity is max, then expel LRU
        /// if key exist, update value, and bring to head
    }
    
    func get(key: Key) -> Value? {
        
        // check the cache for existence
        guard let node = lookup[key] else { return nil }
        
        // update the value we found, and move to front of cache
        detach(node: node)
        prepend(node: node)
        
        return node.value
    }
    
    private func detach(node: Node<Value>) {
        // remove from LL
        if let prev = node.prev {
            prev.next = node.next
        }
        
        if let next = node.next {
            next.prev = node.prev
        }
        
        if head == node {
            head = node.next
        }
        
        if tail == node {
            tail = node.prev
        }
        
        node.next = nil
        node.prev = nil
        // we don't actually change the length here
    }
    
    private func prepend(node: Node<Value>) {
        // add to head of LL
        if head != nil {
            node.next = head
            head?.prev = node
            head = node
        } else {
            head = node
            tail = node
        }
    }
    
    private func trimCache() {
        guard length > capacity, let tail else { return }
        self.tail = tail.prev
        detach(node: tail)
        
        // remove from lookup
        guard let key = reverseLookup[tail] else { return }
        lookup[key] = nil
        reverseLookup[tail] = nil
        
        length -= 1
    }
}
