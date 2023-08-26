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
        for n in haystack {
            if (n == needle) {
                return true
            }
        }
        
        return false
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
    
    /**
     O(sqrt(N))
     
        Given 2 crystal balls and a building of N stories high, find the floor in which the crystal balls will break if they are dropped from.
     */
    
    func twoCrystalBalls(breaks: [Bool]) -> Int {
        let jumpAmount = Int(floor(Double(breaks.count)).squareRoot())
        var floor = jumpAmount
        
        while floor < breaks.count {
            let didBreak = breaks[floor]
            if didBreak {
                // loop through the remaining
                let lo = floor - jumpAmount + 1
                let hi = floor
                
                for inBetweenFloors in lo...hi {
                    let breaks = breaks[inBetweenFloors]
                    if (breaks) {
                        return inBetweenFloors
                    }
                }
            } else {
                floor += jumpAmount
            }
        }
        
        return -1
    }
}
