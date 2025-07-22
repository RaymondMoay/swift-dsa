//
//  SwiftDSA.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Foundation

/// O(N)
struct LinearSearch {
    
    static func perform<T: Equatable>(array: [T], value: T) -> Bool {
        for item in array {
            if item == value {
                return true
            }
        }
        return false
    }
}
