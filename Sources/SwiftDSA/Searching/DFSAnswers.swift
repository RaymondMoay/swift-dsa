//
//  DFSAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 24/6/25.
//

struct DFSAnswers {
    
    // MARK: Traversal
    
    enum Traversal {
        
        static func performPreOrder(head: BinaryNode<Int>) -> [Int] {
            
            func walk(arr: inout [Int], curr: BinaryNode<Int>?) {
                // base case
                guard let curr else { return }
                
                // recurse
                
                // 1. Pre
                arr.append(curr.value)
                // 2. Recurse
                walk(arr: &arr, curr: curr.left)
                walk(arr: &arr, curr: curr.right)
                // 3. Post
            }
            
            var arr: [Int] = []
            walk(arr: &arr, curr: head)
            return arr
        }
        
        static func performInOrder(head: BinaryNode<Int>) -> [Int] {
            func walk(arr: inout [Int], curr: BinaryNode<Int>?) {
                // base case
                guard let curr else { return }
                
                // recurse
                
                // 1. Pre
                // 2. Recurse
                walk(arr: &arr, curr: curr.left)
                arr.append(curr.value)
                walk(arr: &arr, curr: curr.right)
                // 3. Post
            }
            
            var arr: [Int] = []
            walk(arr: &arr, curr: head)
            return arr
        }
        
        static func performPostOrder(head: BinaryNode<Int>) -> [Int] {
            func walk(arr: inout [Int], curr: BinaryNode<Int>?) {
                // base case
                guard let curr else { return }
                
                // recurse
                
                // 1. Pre
                // 2. Recurse
                walk(arr: &arr, curr: curr.left)
                walk(arr: &arr, curr: curr.right)
                // 3. Post
                arr.append(curr.value)
            }
            
            var arr: [Int] = []
            walk(arr: &arr, curr: head)
            return arr
        }
    }
    
    // MARK: Search
    
    enum Search {
        
        // Good if you know the value you want to find is high up in the tree, i.e. a sorted node
        static func performPreorder(head: BinaryNode<Int>, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                // base case
                
                // 1. If node ends, stop searching that node
                guard let curr else { return false }
                
                // recurse
                
                // 1. Pre
                
                if curr.value == needle { // kind of like a base case
                    return true
                }
                
                // recurse
                
                if walk(curr: curr.left, needle: needle) {
                    return true
                }
                if walk(curr: curr.right, needle: needle) {
                    return true
                }
                
                // post
                return false
            }
            
            return walk(curr: head, needle: needle)
        }
        
        // Good if you don't know where the value you want to find is likely to be
        static func performInorder(head: BinaryNode<Int>, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                // base case
                
                // 1. curr is nil, stop traversing that path
                guard let curr else { return false }
                
                // recurse
                
                // 1. pre
                
                // 2. recurse
                
                if walk(curr: curr.left, needle: needle) {
                    return true
                }
                if curr.value == needle {
                    return true
                }
                if walk(curr: curr.right, needle: needle) {
                    return true
                }
                
                // 3. post
                return false
            }
            
            return walk(curr: head, needle: needle)
        }
        
        // Good if you know the value you want is deep in the tree, i.e. a sorted node
        static func performPostorder(head: BinaryNode<Int>, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                // base case
                guard let curr else { return false }
                
                // recurse
                
                // 1. pre
                
                // 2. recurse
                if walk(curr: curr.left, needle: needle) {
                    return true
                }
                
                if walk(curr: curr.right, needle: needle) {
                    return true
                }
                
                // 3. post
                if curr.value == needle {
                    return true
                }
                
                return false
            }
            
            return walk(curr: head, needle: needle)
        }
    }
    
    // MARK: Binary Search
    
    // It needs to be sorted where left ≤ head < right. Run time is probably O(log(n)).
    enum BinarySearch {
        
        static func perform(head: BinaryNode<Int>?, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                
                // base case
                
                // 1. are you nil?
                guard let curr else { return false }
                
                // 2. are you equal?
                if curr.value == needle {
                    return true
                }
                
                // recurse
                
                if needle < curr.value {
                    return walk(curr: curr.left, needle: needle)
                }
                
                if needle > curr.value {
                    return walk(curr: curr.right, needle: needle)
                }
                
                return false
            }
            
            return walk(curr: head, needle: needle)
        }
    }
}
