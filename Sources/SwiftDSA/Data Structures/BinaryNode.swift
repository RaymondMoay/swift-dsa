//
//  BinaryNode.swift
//  SwiftDSA
//
//  Created by Ray on 22/6/25.
//

class BinaryNode<T> {
    
    let value: T
    let left: BinaryNode<T>?
    let right: BinaryNode<T>?
    
    init(value: T, left: BinaryNode<T>?, right: BinaryNode<T>?) {
        self.value = value
        self.left = left
        self.right = right
    }
}
