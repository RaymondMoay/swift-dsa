//
//  BinarySearch.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Foundation

/// O(log(N))
///
/// Remember that whenever we half things, we are doing Log(base2), hence a logarithmic algorithm.
/// Very efficient with large N, as we are skipping even larger number of "Steps".
struct BinarySearch {
    
    static func perform(array: [Int], value: Int) -> Bool {
        var lo = 0
        var hi = array.count
        
        while (lo < hi) {
            let mid = lo + (hi - lo) / 2
            let midVal = array[mid]
            if value == midVal {
                return true
            } else if value < midVal {
                hi = mid
            } else {
                lo = mid + 1
            }
        }
        return false
    }
}
