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
    
    private static func walkIsland(mapBook: inout [[Int]],
                                   seen: inout [[Bool]],
                                   curr: Point) {
        // base cases
        // are you out of bounds?
        if (curr.x < 0 || curr.x >= mapBook[0].count ||
            curr.y < 0 || curr.y >= mapBook.count) {
            return
        }
        
        // have i seen you before?
        if seen[curr.y][curr.x] {
            return
        }
        
        if mapBook[curr.y][curr.x] == 0 {
            return
        }
        
        // recurse
        
        // pre
        seen[curr.y][curr.x] = true
        
        // recurse
        for direction in directions {
            walkIsland(mapBook: &mapBook, seen: &seen, curr: (x: curr.x + direction.x,
                                                              y: curr.y + direction.y))
        }
        
        // post
        mapBook[curr.y][curr.x] = 0 // mark it as explored (non-island), so we don't check it again in the future.
    }
    
    private static func sail(mapBook: inout [[Int]],
                     seen: inout [[Bool]],
                     curr: Point,
                     numberOfIslands: inout Int) {
        // base cases
        // are you out of bounds?
        if (curr.x < 0 || curr.x >= mapBook[0].count ||
            curr.y < 0 || curr.y >= mapBook.count) {
            return
        }
        
        // have i seen you before?
        if seen[curr.y][curr.x] {
            return
        }
        
        // recurse
        // pre
        if mapBook[curr.y][curr.x] == 1 {
            // walk island
            var landSeen = seen
            walkIsland(mapBook: &mapBook, seen: &landSeen, curr: curr)
            numberOfIslands += 1
        }
        seen[curr.y][curr.x] = true
        // recurse
        for direction in directions {
            sail(mapBook: &mapBook,
                 seen: &seen,
                 curr: (x: curr.x + direction.x,
                        y: curr.y + direction.y),
                 numberOfIslands: &numberOfIslands)
        }
        // post
    }
    
    static func perform(map: [[Int]]) -> Int {
        
        var numberOfIslands: Int = 0
        var seen: [[Bool]] = map.map { mapRow in
            Array(repeating: false, count: mapRow.count)
        }
        var mapBook = map
        
        sail(mapBook: &mapBook, seen: &seen, curr: (x: 0, y: 0), numberOfIslands: &numberOfIslands)
        
        return numberOfIslands
    }
}
