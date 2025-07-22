//
//  DFS.swift
//  SwiftDSA
//
//  Created by Ray on 23/6/25.
//

struct DFS {
    
    // MARK: Traversal
    
    enum Traversal {
        
        static func performPreOrder(head: BinaryNode<Int>) -> [Int] {
            var result: [Int] = []
            
            func walk(curr: BinaryNode<Int>?, arr: inout [Int]) {
                // base case
                guard let curr else { return }
                
                // recurse
                
                // 1. pre
                arr.append(curr.value)
                // 2. recurse
                walk(curr: curr.left, arr: &arr)
                walk(curr: curr.right, arr: &arr)
                // 3. post
            }
            
            walk(curr: head, arr: &result)
            
            return result
        }
        
        static func performInOrder(head: BinaryNode<Int>) -> [Int] {
            var result: [Int] = []
            
            func walk(curr: BinaryNode<Int>?, arr: inout [Int]) {
                // base case
                guard let curr else { return }
                
                // recurse
                //1. pre
                //2. recurse
                walk(curr: curr.left, arr: &arr)
                arr.append(curr.value)
                walk(curr: curr.right, arr: &arr)
                //3. post
            }
            
            walk(curr: head, arr: &result)
            
            return result
        }
        
        static func performPostOrder(head: BinaryNode<Int>) -> [Int] {
            var result: [Int] = []
            
            func walk(curr: BinaryNode<Int>?, arr: inout [Int]) {
                // base case
                guard let curr else { return }
                
                // recurse
                //1. pre
                //2. recurse
                walk(curr: curr.left, arr: &arr)
                walk(curr: curr.right, arr: &arr)
                //3. post
                arr.append(curr.value)
            }
            
            walk(curr: head, arr: &result)
            
            return result
        }
    }
    
    // MARK: Search
    
    enum Search {
        
        // Good if you know the value you want to find is high up in the tree, i.e. a sorted node
        static func performPreorder(head: BinaryNode<Int>, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                // base case
                guard let curr else { return false }
                
                // recurse
                // 1. pre
                if curr.value == needle { return true }
                // 2. recurse
                return walk(curr: curr.left, needle: needle) || walk(curr: curr.right, needle: needle)
                // 3. post
            }
            
            return walk(curr: head, needle: needle)
        }
        
        // Good if you don't know where the value you want to find is likely to be
        static func performInorder(head: BinaryNode<Int>, needle: Int) -> Bool {
            
            func walk(curr: BinaryNode<Int>?, needle: Int) -> Bool {
                // base case
                guard let curr else { return false }
                
                // recurse
                if walk(curr: curr.left, needle: needle) {
                    return true
                }
                
                if curr.value == needle {
                    return true
                }
                
                if walk(curr: curr.right, needle: needle) {
                    return true
                }
                
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
                guard let curr else { return false }
                
                if curr.value == needle {
                    return true
                } else if needle < curr.value {
                    return walk(curr: curr.left, needle: needle)
                } else {
                    return walk(curr: curr.right, needle: needle)
                }
            }
            
            return walk(curr: head, needle: needle)
        }
    }
}
