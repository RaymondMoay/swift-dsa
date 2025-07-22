//
//  MazeSolverTests.swift
//  SwiftDSA
//
//  Created by Ray on 19/6/25.
//

import Testing

@testable import SwiftDSA

struct MazeSolverTests {
    
    @Test
    func testMazeSolver() async throws {
        let maze = [
            "xxxxxxxxxx x",
            "x        x x",
            "x        x x",
            "x xxxxxxxx x",
            "x          x",
            "x xxxxxxxxxx"
        ]

        let expectedPath = [
            Point(x: 10, y: 0),
            Point(x: 10, y: 1),
            Point(x: 10, y: 2),
            Point(x: 10, y: 3),
            Point(x: 10, y: 4),
            Point(x: 9, y: 4),
            Point(x: 8, y: 4),
            Point(x: 7, y: 4),
            Point(x: 6, y: 4),
            Point(x: 5, y: 4),
            Point(x: 4, y: 4),
            Point(x: 3, y: 4),
            Point(x: 2, y: 4),
            Point(x: 1, y: 4),
            Point(x: 1, y: 5)
        ]

        let start = Point(x: 10, y: 0)
        let end = Point(x: 1, y: 5)

        let result = MazeSolver.perform(maze: maze, wall: "x", start: start, end: end)
        #expect(drawPath(maze: maze, path: result) == drawPath(maze: maze, path: expectedPath))
    }

    func drawPath(maze: [String], path: [Point]) -> [String] {
        var mazeGrid = maze.map { Array($0) }

        for point in path {
            if point.y >= 0 && point.y < mazeGrid.count && point.x >= 0 && point.x < mazeGrid[point.y].count {
                mazeGrid[point.y][point.x] = "*"
            }
        }

        return mazeGrid.map { String($0) }
    }
}
