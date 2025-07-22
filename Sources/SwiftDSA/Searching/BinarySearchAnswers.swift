//
//  BinarySearchAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 21/6/25.
//

import Foundation

struct BinarySearchAnswers {
    
    static func perform(array: [Int], value: Int) -> Bool {
        var low = 0
        var high = array.count
        
        while low < high {
            let mid = low + (high - low) / 2
            let midValue = array[mid]
            if midValue == value {
                return true
            } else if value > midValue {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return false
    }
}
