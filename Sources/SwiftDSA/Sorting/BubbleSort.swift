//
//  BubbleSort.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

/// O(N^2) time complexity.
///
/// Technically, it is a more complex algorithm, (n(n-1)) / 2, we omit constants and n, so we are left with n^2.
/// Bubble sorts are really bad when it is a descending order. 
struct BubbleSort {
    
    static func perform(array: [Int]) -> [Int] {
        var array = array
        for i in 0..<array.count {
            for j in 0..<array.count - i - 1 {
                if array[j] > array[j+1] {
                    array.swapAt(j, j+1)
                }
            }
        }
        return array
    }
}
