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
        let length = numbers.count
        
        for i in 0..<length {
            // -1 to prevent array out of bounds
            for j in 0..<(length - 1 - i) {
                if sorted[j] > sorted[j+1] {
                    sorted.swapAt(j, j+1)
                    print(sorted)
                }
            }
        }
        
        return sorted
    }
}
