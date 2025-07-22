//
//  QuickSort.swift
//  SwiftDSA
//
//  Created by Ray on 20/6/25.
//


/// Why is this memory efficient? `inout`? YES
///
/// Is this generally better than bubble sort? Since its O(nlog(n)) to O(n^2) whereas bubble sort is always O(n^2). YES
struct QuickSortAnswers {
    
    // 1. Partition - moves and returns the pivot index
    static func partition(arr: inout [Int], lo: Int, hi: Int) -> Int {
        let pivot = arr[hi] // best case to partition by randomly selecting to avoid O(n^2)
        var index = lo - 1
        
        for i in lo..<hi {
            if arr[i] <= pivot {
                index += 1
                arr.swapAt(index, i)
            }
        }
        
        index += 1
        arr.swapAt(index, hi)
        
        return index
    }
    
    // 2. QS
    static func qs(arr: inout [Int], lo: Int, hi: Int) {
        // base case
        if lo >= hi { // last recursion, partitioned arr is now of count == 1
            // technically, it is only 1 array, we are using index pointers to manipulate around it.
            return
        }
        
        let pivot = partition(arr: &arr, lo: lo, hi: hi)
        
        // recursion
        qs(arr: &arr, lo: lo, hi: pivot - 1)
        qs(arr: &arr, lo: pivot + 1, hi: hi)
    }
    
    static func perform(_ arr: inout [Int]) {
        qs(arr: &arr, lo: 0, hi: arr.count - 1) // include the highest
    }
}
