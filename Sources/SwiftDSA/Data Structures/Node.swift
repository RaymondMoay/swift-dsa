//
//  Node.swift
//  SwiftDSA
//
//  Created by Ray on 24/6/25.
//

class Node<V: Hashable>: Hashable {
    
    var value: V
    var next: Node<V>?
    var prev: Node<V>?
    
    init(value: V, next: Node<V>? = nil, prev: Node<V>? = nil) {
        self.value = value
        self.next = next
        self.prev = prev
    }
    
    // MARK: - Hashable Conformance

    /// we can simply hash the value. Prev and enxt doesn't matter. We hash the value, so we can store the modulo of capacity into the bucket.
    /// We are simply using the hashed value to determine the "key" in teh underlying array list.
    func hash(into hasher: inout Hasher) {
        hasher.combine(value) // hashing -> modulo -> store in correct bucket
    }

    // MARK: - Equatable Conformance

    // Required for Hashable (Hashable inherits from Equatable):
    // Defines when two Node instances are considered equal.
    // Two nodes are equal if their 'value' properties are equal.
    // Similar to hashing, we don't compare 'next' or 'prev' here
    // to avoid structural comparison for individual node equality.
    static func == (lhs: Node<V>, rhs: Node<V>) -> Bool {
        return lhs.value == rhs.value
    }
}
