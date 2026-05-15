// MARK: - 🚪 Escape the Burning Building
//
// You're given an `m x n` grid representing a building floor. Each cell is one of:
//
//   '.'  — empty room (walkable)
//   '#'  — wall (impassable)
//   'F'  — fire (spreads each minute to adjacent '.' cells, 4-directionally)
//   'E'  — exit (you escape when you step here)
//   'P'  — you, the person (exactly one P on the grid)
//
// Each minute:
//   1. YOU move first to an adjacent empty cell (up/down/left/right), or stay put.
//   2. THEN the fire spreads to all adjacent empty cells.
//
// You cannot step into a cell that is currently on fire, will be on fire after the
// spread, or a wall. Fire cannot pass through walls. You start at `P`.
//
// Return the minimum number of minutes to reach any exit `E`, or `-1` if impossible.
//
// Example:
//   [['.','.','.','.','F'],
//    ['.','#','#','.','.'],
//    ['.','P','#','.','.'],
//    ['.','.','#','.','.'],
//    ['E','.','.','.','.']]
//
//   Expected output: 3
//
// Constraints:
//   - 1 <= m, n <= 300
//   - Exactly one `P`, at least one `E`, zero or more `F`.

import Foundation

func escapeBurningBuilding(_ grid: [[Character]]) -> Int {

    // setup
    typealias Point = (x: Int, y: Int)
    let directions: [Point] = [
        (x: 1, y: 0),
        (x: -1, y: 0),
        (x: 0, y: 1),
        (x: 0, y: -1),
    ]

    func isOob(_ point: Point) -> Bool {
        point.x < 0 || point.y < 0 || point.x >= grid[0].count || point.y >= grid.count
    }

    // Find the start points
    var start: Point? = nil
    var fireStarts: [Point] = []

    for y in 0..<grid.count {
        for x in 0..<grid[0].count {
            if grid[y][x] == "P" {
                start = (x: x, y: y)
            }
            if grid[y][x] == "F" {
                fireStarts.append((x: x, y: y))
            }
        }
    }

    guard let start else { return 0 } // I am never in the room!

    // Two problems to solve:
    // 1. Fire's grow path O(mn)
        // - BF-spread, store a cache of each coordinates if they are on fire at time t
        // - BF-spread is leveled, to process multiple points of fire
    
    var fireMap: [[Int]] = grid.map {
        Array(repeating: Int.max, count: grid[0].count)
    }
    var fireSeen: [[Bool]] = grid.map {
        Array(repeating: false, count: grid[0].count)
    }

    for fireStart in fireStarts {
        fireSeen[fireStart.y][fireStart.x] = true
    }

    var fireQueue: [[Point]] = [fireStarts] // assuming this is a queue, in reality, array lists are O(n) for removeFirst() / unshift
    var fireMinute: Int = 0
    while !fireQueue.isEmpty {
        let currFireStarts = fireQueue.removeFirst()
        var newPoints: [Point] = []
        for currFireStart in currFireStarts {
            // set the time it lits on fire
            fireMap[currFireStart.y][currFireStart.x] = fireMinute
            // walk its adjacencies and add to fireQueue to process
            for dir in directions {
                let newFirePoint = (x: currFireStart.x + dir.x, y: currFireStart.y + dir.y)

                // base cases
                if isOob(newFirePoint) { continue }
                if grid[newFirePoint.y][newFirePoint.x] == "#" { continue }
                if grid[newFirePoint.y][newFirePoint.x] == "E" { continue }
                if fireSeen[newFirePoint.y][newFirePoint.x] == true { continue }

                fireSeen[newFirePoint.y][newFirePoint.x] = true // mark seen on enqueue so it does not get seen again
                newPoints.append(newFirePoint)
            }
        }
        fireQueue.append(newPoints)
        fireMinute += 1
    }

    // 2. Shortest path to exit O(mn)
        // - process every adjs in the same minute
        // - "hey, can I walk here at this time?"
    
    var seen: [[Bool]] = grid.map {
        Array(repeating: false, count: grid[0].count)
    }
    seen[start.y][start.x] = true
    var queue: [[Point]] = [[start]]
    var minute: Int = 0

    while !queue.isEmpty {
        let currPoints = queue.removeFirst()
        for point in currPoints {
            var newPoints: [Point] = []
            for dir in directions {
                let newPoint = (x: point.x + dir.x, y: point.y + dir.y)

                // base cases
                if isOob(newPoint) { continue }
                if grid[newPoint.y][newPoint.x] == "#" { continue }
                if grid[newPoint.y][newPoint.x] == "E" { 
                    return minute + 1 // in order to walk to E, we need 1 more minute
                 }
                 if seen[newPoint.y][newPoint.x] == true { continue }
                 if fireMap[newPoint.y][newPoint.x] <= minute + 1 { continue } // + 1 for fire checks

                 seen[newPoint.y][newPoint.x] = true
                 newPoints.append(newPoint)
            }
            queue.append(newPoints)
        }
        minute += 1 // advance the time
    }

    return -1 // if never returned, means i burned to death sadly
}

// MARK: At 10,000 x 10,000, how can I improve this?
// 1. O(mn) is required, so time complexity can't be improved, but space can. Instead of Int, use Int16 if permitted.
// 2. Use available information, "E"'s path is not used! How can we improve on this? Well -> bias the BFS towards E, now that we know it. (Solution is A* with manhattan heuristic)