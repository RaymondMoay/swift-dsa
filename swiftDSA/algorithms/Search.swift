//
//  Search.swift
//  swiftDSA
//
//  Created by Raymond Moay on 1/8/23.
//

import Foundation

struct SearchAlgo {
    /**
     O(N)
     */
    func linearSearch(needle: Int, haystack: [Int]) -> Bool {
        return haystack.contains(needle) // sub for a for loop and it will work too
    }
    
    /**
     O(log(N))
     */
    func binarySearch(needle: Int, haystack: [Int]) -> Bool {
        var low = 0.0
        var high = Double(haystack.count)
        
        while low < high {
            let mid = floor(low + (high - low) / 2.0)
            let value = haystack[Int(mid)]
            
            if needle == value {
                return true
            } else if needle > value {
                low = mid + 1
            } else {
                high = mid
            }
        }
        
        return false
    }
}
