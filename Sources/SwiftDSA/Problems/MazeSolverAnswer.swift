//
//  MazeSolverAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 20/6/25.
//

extension MazeSolver {
    
    struct Answer {
        
        @discardableResult
        static func walk(maze: [String],
                         wall: String,
                         curr: Point,
                         end: Point,
                         seen: inout [[Bool]],
                         path: inout [Point]) -> Bool {
            // base case
            
            // 1. off the map
            if (curr.x < 0 || curr.x > maze[0].count ||
                curr.y < 0 || curr.y > maze.count) {
                return false
            }
            
            // 2. Are we on a wall?
            if maze[curr.y][safe: curr.x] == wall {
                return false
            }
            
            // 3. Are we at the end?
            if curr == end {
                path.append(end)
                return true
            }
            
            // 4. Have we seen this before?
            if seen[curr.y][curr.x] {
                return false
            }
            
            // recursion case
            
            // 1. pre
            seen[curr.y][curr.x] = true
            path.append(curr)
            
            // 2. recurse
            for dir in directions { // try all 4 directions from the current tile
                if walk(maze: maze, wall: wall,
                        curr: .init(x: curr.x + dir.x,
                                    y: curr.y + dir.y),
                        end: end, seen: &seen, path: &path) {
                    return true
                }
            }
            
            // 3. post, if we come back out...
            _ = path.popLast()
            
            return false
        }
        
        static func perform(maze: [String], wall: String, start: Point, end: Point) -> [Point] {
            var path: [Point] = []
            var seen: [[Bool]] = []
            
            for row in maze {
                seen.append(Array(repeating: false, count: row.count))
            }
            
            walk(maze: maze, wall: wall, curr: start, end: end, seen: &seen, path: &path)
            
            return path
        }
    }
}

private extension String {
    subscript(safe index: Int) -> String? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[stringIndex])
    }
}
