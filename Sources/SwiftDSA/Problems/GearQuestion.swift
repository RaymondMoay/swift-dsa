//
//  GearQuestion.swift
//  SwiftDSA
//
//  Created by Ray on 3/7/25.
//

//let connections: [[Int]] = [
//    [0,2],
//    [2,4],
//    [2,1],
//    [1,3],
//    [3,4]
//]

struct GearQuestion {
    
    static func perform(connections: [[Int]]) -> [Int] {
        
        enum Rotation {
            case clockwise, anticlockwise, impossible
            
            var nextRotation: Self {
                if self == .clockwise {
                    return .anticlockwise
                } else {
                    return .clockwise
                }
            }
        }
        
        /// [0,2], [2,4], [2,1] -> [0, 4, 1] -> check for my base cases
        func ajds(for gear: Int, from connections: [[Int]]) -> [Int] {
            connections
                .filter { $0.contains(gear) }
                .flatMap { $0 }
                .filter { $0 != gear }
        }
        
        func walk(gear: Int, targetRotation: Rotation, connections: [[Int]], rotations: inout [Rotation?]) {
            // base case
            // 1. have i been rotated before?
            if rotations[gear] != nil { return }
            
            // 2. how about my adjacencies?
            let adjs = ajds(for: gear, from: connections)
            for adj in adjs {
                // are you my target rotation?
                if rotations[adj] == targetRotation {
                    rotations = Array(repeating: .impossible, count: rotations.count)
                    break
                } else {
                    //if not, proceed to rotate
                    rotations[gear] = targetRotation
                    walk(gear: adj, targetRotation: targetRotation.nextRotation,
                         connections: connections, rotations: &rotations)
                }
            }
        }
        
        let numberOfGears = connections.flatMap({ $0 }).max()! + 1
        
        var rotations: [Rotation?] = Array(repeating: nil, count: numberOfGears)
        
        walk(gear: 0, targetRotation: .clockwise, connections: connections, rotations: &rotations)
        
        // count
        if rotations.contains(.impossible) { // set everything, this will meet first element and return, so its effectively O(1)
            return [-1, -1]
        } else {
            return [
                rotations.filter { $0 == .clockwise }.count,
                rotations.filter { $0 == .anticlockwise }.count
            ]
        }
    }
}
