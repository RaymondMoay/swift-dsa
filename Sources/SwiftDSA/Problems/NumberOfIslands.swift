//
//  NumberOfIslands.swift
//  SwiftDSA
//
//  Created by Ray on 2/7/25.
//

/// Given a 2d array of integers which may NOT be a square, find the number of islands.
/// Islands here means the number of group of 1s bounded by 0s.
///
/// [
///     [0,0,1,0,1,0]
///     [0,0,0,0,1,1]
///     [0,0,0,0,0,1]
///     [0,0,0,0,0,0]
/// ]
///
struct NumberOfIslands {
    
    typealias Point = (x: Int, y: Int)
    
    private static let directions: [Point] = [
        (x: 1, y: 0),
        (x: -1, y: 0),
        (x: 0, y: 1),
        (x: 0, y: -1),
    ]
    
    static func perform(map: [[Int]], start: Point) -> Int {
        
        var seen: [[Bool]] = map.map { Array(repeating: false, count: $0.count) }
        var mapBook = map
        var islandCount: Int = 0
        
        func explore(curr: Point) {
            
            // base
            // am i out of bounds?
            if curr.y < 0 || curr.y >= map.count || curr.x < 0 || curr.x >= map[0].count { return }
            
            // have i seen this before?
            if seen[curr.y][curr.x] { return }
            
            // recurse
            
            // pre
            seen[curr.y][curr.x] = true
            
            // recurse
            if mapBook[curr.y][curr.x] == 1 {
                islandCount += 1
                walk(curr: curr)
            }
            
            for direction in directions {
                explore(curr: Point(x: curr.x + direction.x, y: curr.y + direction.y))
            }
        }
        
        func walk(curr: Point) {
            // base
            
            if curr.y < 0 || curr.y >= map.count || curr.x < 0 || curr.x >= map[0].count { return }
            
            if mapBook[curr.y][curr.x] == 0 { return }
            
            // recurse
            // pre
            mapBook[curr.y][curr.x] = 0
            for direction in directions {
                walk(curr: Point(x: curr.x + direction.x, y: curr.y + direction.y))
            }
        }
        
        explore(curr: start)
        
        return islandCount
    }
}

// TODO: Do properly with grid-based flooding.
