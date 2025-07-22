//
//  GearQuestionAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 7/7/25.
//

struct GearQuestionAnswer {
    
    static func perform(connections: [[Int]]) -> [Int] {
        
        // SETUP
        
        enum Rotation {
            case clockwise, antiClockwise, impossible
            
            var nextRotation: Self {
                if self == .clockwise {
                    return .antiClockwise
                } else {
                    return .clockwise
                }
            }
        }
        
        func canTurnCog(targetRotation: Rotation, adjs: [Int], rotations: [Rotation?]) -> Bool {
            for i in 0..<adjs.count {
                let adjRotation = rotations[i]
                if adjRotation == nil || adjRotation != targetRotation {
                    return true
                }
            }
            return false
        }
        
        func getAdjs(for gear: Int, in connections: [[Int]]) -> [Int] {
            var out: [Int] = []
            for con in connections {
                if con.contains(gear) {
                    out += con
                }
            }
            return out.filter { $0 != gear }
        }
        
        // Logic
        
        let count = (connections.flatMap(\.self).max() ?? 0) + 1
        var rotations: [Rotation?] = Array(repeating: nil, count: count)
        
        func walk(curr: Int, connections: [[Int]], rotations: inout [Rotation?], rotate: Rotation) {
            
            // base case
            
            // 1. Have i seen you before?
            if rotations[curr] != nil {
                return
            }
            
            // Recurse
            
            // pre-
            let adjs = getAdjs(for: curr, in: connections)
            
            if (canTurnCog(targetRotation: rotate, adjs: adjs, rotations: rotations)) {
                print(">>> \(curr) rotated: \(rotate)")
                rotations[curr] = rotate
            } else {
                rotations = Array(repeating: .impossible, count: rotations.count)
            }
            
            // recurse
            for gear in adjs {
                walk(curr: gear, connections: connections, rotations: &rotations, rotate: rotate.nextRotation)
            }
            // post
        }
        
        walk(curr: 0, connections: connections, rotations: &rotations, rotate: .clockwise)
        
        // reconcile
        if rotations.contains(.impossible) {
            return [-1, -1]
        } else {
            return [
                rotations.filter { $0 == .clockwise }.count,
                rotations.filter { $0 == .antiClockwise }.count,
            ]
        }
    }
}
