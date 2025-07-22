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
    
    static func partition(arr: inout [Int], lo: Int, hi: Int) -> Int {
        let pivot = arr[hi]
        var idx = lo - 1
        
        for i in lo..<hi {
            if arr[i] <= pivot {
                // swap
                idx += 1
                arr.swapAt(idx, i)
            }
        }
        
        idx += 1
        arr.swapAt(idx, hi)
        return idx
    }
    
    static func qs(arr: inout [Int], lo: Int, hi: Int) {
        
        // base case
        if lo >= hi {
            return
        }
        
        // recurse
        // pre
        let pivot = partition(arr: &arr, lo: lo, hi: hi)
        
        qs(arr: &arr, lo: lo, hi: pivot - 1)
        qs(arr: &arr, lo: pivot + 1, hi: hi)
    }
    
    static func perform(_ arr: inout [Int]) {
        qs(arr: &arr, lo: 0, hi: arr.count - 1)
    }
}
