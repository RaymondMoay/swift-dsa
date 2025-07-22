//
//  CompareBinaryTreeAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 24/6/25.
//

struct CompareBinaryTreeAnswer {
    
    /// Compare 2 binary trees and see if they are structurally equivalent.
    ///
    /// Solution here is to use DFS instead of BFS, because DFS uses a recursive "stack", and so it preserves shape.
    /// When comparing structural equality, DFS is superior because of this property.
    static func perform(headA: BinaryNode<Int>?, headB: BinaryNode<Int>?) -> Bool {
        
        func compare(currA: BinaryNode<Int>?, currB: BinaryNode<Int>?) -> Bool { // in recursion, helps to think that this walk function basically solves for one single node itself! and the recursion below is where it resolves for all the cases!
            
            // base case
            
            // 1. Are either of you nil?
            if currA?.value == nil || currB?.value == nil {
                return currA?.value == currB?.value // if so, are you both nil?
            }
            
            // 2. are you equal? If not, quickly exit!
            if currA?.value != currB?.value {
                return false
            }
            
            // recurse
            
            // 1. pre
            
            // 2. recurse
            return compare(currA: currA?.left, currB: currB?.left) && compare(currA: currA?.right, currB: currB?.right)
            
            // 3. post
        }
        
        return compare(currA: headA, currB: headB)
    }
}
