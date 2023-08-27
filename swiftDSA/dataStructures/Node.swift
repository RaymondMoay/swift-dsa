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
    
    init(value: T, next: Node<T>?) {
        self.value = value
        self.next = next
    }
}
