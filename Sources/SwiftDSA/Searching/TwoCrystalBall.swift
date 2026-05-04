//
//  TwoCrystalBall.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Foundation

/// O(sqrt(N))
///
/// Given you have 2 crystal balls, and you are in a tall building, find the lowest floor in which the crystal ball with break at.
///
/// This problem combines the "idea" of a binary sort, where we split the array and check, before looping through.
struct TwoCrystalBall {
    
    /// given breaks.count == 100
    static func perform(breaks: [Bool]) -> Int {
        let stride = Int(sqrt(Double(breaks.count)))
        
        for i in 1...stride {
            let jumpIndex = min(stride * i - 1, breaks.count - 1)
            if breaks[jumpIndex] {
                let startIndex = jumpIndex - stride + 1
                for i in startIndex..<jumpIndex {
                    if breaks[i] {
                        return i
                    }
                }
            }
        }
        
        return -1
    }
}
