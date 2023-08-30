//
//  Node.swift
//  swiftDSA
//
//  Created by Raymond Moay on 27/8/23.
//

import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?
    var prev: Node<T>?
    
    init(value: T, next: Node<T>? = nil, prev: Node<T>? = nil) {
        self.value = value
        self.next = next
        self.prev = prev
    }
}
