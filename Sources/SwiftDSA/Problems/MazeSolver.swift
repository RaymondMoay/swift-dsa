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
        
        func walk(maze: [String], wall: String, curr: Point, end: Point, seen: inout [[Bool]], paths: inout [Point]) -> Bool {
            // base case
            
            // 1. are you out of bounds?
            if (curr.x < 0 || curr.x >= maze[0].count ||
                curr.y < 0 || curr.y >= maze.count) {
                return false
            }
            
            // 2. are you at the end?
            if curr == end {
                paths.append(curr)
                return true
            }
            
            // 3. are you a wall?
            if maze[curr.y][safe: curr.x] == wall {
                return false
            }
            
            // 4. have i seen you before
            if seen[curr.y][curr.x] {
                return false
            }
            
            // recurse
            
            // pre
            seen[curr.y][curr.x] = true
            paths.append(curr)
            // recurse
            
            for direction in directions {
                if walk(maze: maze, wall: wall,
                        curr: .init(x: curr.x + direction.x,
                                    y: curr.y + direction.y),
                        end: end,
                        seen: &seen,
                        paths: &paths) {
                    return true
                }
            }
            
            // post
            _ = paths.popLast()
            return false
        }
        
        var seen: [[Bool]] = []
        
        for mazeRow in maze {
            seen.append(Array(repeating: false, count: mazeRow.count))
        }
        
        _ = walk(maze: maze, wall: wall, curr: start, end: end, seen: &seen, paths: &paths)
        
        return paths
    }
}

private extension String {
    subscript(safe index: Int) -> String? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
}
