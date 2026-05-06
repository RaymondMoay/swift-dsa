//
//  MazeSolver.swift
//  SwiftDSA
//
//  Created by Ray on 19/6/25.
//

struct Point: Equatable {
    var x: Int
    var y: Int
}

/// O(N)
///
/// Technically, it is O(4N), since for infinite tiles, we will walk each tile in 4 directions.
///
/// The key in recursion is to always define the base case, then the recurse case.
/// And within recurse, make use of pre and post!
struct MazeSolver {
    
    static let directions: [Point] = [
        .init(x: -1, y: 0),
        .init(x: 1, y: 0),
        .init(x: 0, y: 1),
        .init(x: 0, y: -1),
    ]
    
    static func perform(maze: [String], wall: String, start: Point, end: Point) -> [Point] {
        var paths: [Point] = []
        var seen: [[Bool]] = maze.map {
            .init(repeating: false, count: $0.count)
        }
        
        func walk(maze: [String], wall: String, curr: Point, end: Point, paths: inout [Point], seen: inout [[Bool]]) -> Bool {
            // Base case
            
            // 1. Is this out of bounds
            if curr.x < 0 || curr.x > maze[0].count - 1 || curr.y < 0 || curr.y > maze.count - 1 { return false }
            
            // 2. Have i seen this before?
            if seen[curr.y][curr.x] { return false }
            
            // 3. Is this a wall?
            if maze[curr.y][safe: curr.x] == wall { return false }
            
            // 4. Is this the end?
            if curr == end {
                paths.append(end)
                return true
            }
            
            // Recurse
            
            // Pre
            seen[curr.y][curr.x] = true
            
            // recurse
            for direction in directions {
                let newTile: Point = .init(
                    x: curr.x + direction.x,
                    y: curr.y + direction.y
                )
                
                if walk(maze: maze, wall: wall, curr: newTile, end: end, paths: &paths, seen: &seen) {
                    // Post
                    paths.append(curr)
                    return true
                }
            }
            
            return false
        }
        
        _ = walk(maze: maze, wall: wall, curr: start, end: end, paths: &paths, seen: &seen)
        
        return paths.reversed()
    }
}

private extension String {
    subscript(safe index: Int) -> String? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
}
