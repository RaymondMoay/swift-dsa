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
        let jumpAmount = Int(floor(sqrt(Double(breaks.count)))) // 10
        
        for i in 1...jumpAmount { // iterate from 1...10 progressively
            let jumpIndex = min((i * jumpAmount) - 1, breaks.count - 1)
            if breaks[jumpIndex] == true {
                let startIndex = jumpIndex - jumpAmount + 1
                for i in startIndex...jumpIndex {
                    if breaks[i] == true {
                        return i
                    }
                }
            }
        }
        
        return -1 // does not break
    }
}
