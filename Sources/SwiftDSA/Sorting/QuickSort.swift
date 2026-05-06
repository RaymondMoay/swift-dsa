//
//  QuickSort.swift
//  SwiftDSA
//
//  Created by Ray on 20/6/25.
//


/// Why is this memory efficient? `inout`? YES
///
/// Is this generally better than bubble sort? Since its O(nlog(n)) to O(n^2) whereas bubble sort is always O(n^2). YES
struct QuickSort {
    
    // Returns the new pivot index
    static func partition(arr: inout [Int], lo: Int, hi: Int) -> Int {
        let pivotIndex = hi
        let pivotValue = arr[pivotIndex]
        
        var idx = lo - 1 // swap index
        
        for i in lo..<hi {
            if arr[i] < pivotValue {
                idx += 1
                arr.swapAt(idx, i)
            }
        }
        
        idx += 1
        arr.swapAt(idx, pivotIndex)
        return idx
    }
    
    static func qs(arr: inout [Int], lo: Int, hi: Int) {
        // base case
        
        if lo >= hi { return }
        
        // recurse
        
        // pre
        let partitionIndex = Self.partition(arr: &arr, lo: lo, hi: hi)
        // recurse
        qs(arr: &arr, lo: lo, hi: partitionIndex - 1) // left
        qs(arr: &arr, lo: partitionIndex + 1, hi: hi) // right
        // post
    }
    
    static func perform(_ arr: inout [Int]) {
        qs(arr: &arr, lo: 0, hi: arr.count - 1)
    }
}
