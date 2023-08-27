//
//  SortAlgo.swift
//  swiftDSA
//
//  Created by Raymond Moay on 26/8/23.
//

import Foundation

struct SortAlgo {
    
    /**
     O(n^2)
     */
    func bubbleSort(numbers: [Int]) -> [Int] {
        var sorted = numbers
        
        for i in 0..<sorted.count {
            for j in 0..<(sorted.count - 1 - i) {
                if (sorted[j] > sorted[j+1]) {
                    sorted.swapAt(j, j+1)
                }
            }
        }
        
        return sorted
    }
}
