//
//  CompareBinaryTree.swift
//  SwiftDSA
//
//  Created by Ray on 23/6/25.
//

struct CompareBinaryTree {
    
    /// Given 2 binary trees, see if they are both STRUCTURALLY and VALUE similar.
    static func perform(headA: BinaryNode<Int>?, headB: BinaryNode<Int>?) -> Bool {
        /// DFS preseves structure due to its Stacked nature, so we should use DFS.
        
        func walk(currA: BinaryNode<Int>?, currB: BinaryNode<Int>?) -> Bool {
            
            // base case
            // 1. are you both the same value?
            if currA?.value != currB?.value { return false }
            
            // 2. At the end, are you both nil?
            if currA?.value == nil || currB?.value == nil {
                return currA?.value == currB?.value
            }
            
            // NOTE: Base case needs a positive return value!
            
            // recurse
            if walk(currA: currA?.left, currB: currB?.left) && walk(currA: currA?.right, currB: currB?.right) {
                return true
            }
            
            return false
        }
        
        return walk(currA: headA, currB: headB)
    }
}
