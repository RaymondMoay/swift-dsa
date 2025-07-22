//
//  GearQuestionTests.swift
//  SwiftDSA
//
//  Created by Ray on 3/7/25.
//

import Testing

@testable import SwiftDSA

struct GearQuestionTests {
    
    @Test func assert() async throws {
        let connections: [[Int]] = [
            [0,2],
            [2,4],
            [2,1],
            [1,3],
            [3,4]
        ]
        #expect(GearQuestion.perform(connections: connections) == [3, 2])

        let deadlockConnections: [[Int]] = [
            [0,2],
            [2,1],
            [2,4],
            [2,3],
            [3,4]
        ]
        #expect(GearQuestion.perform(connections: deadlockConnections) == [-1, -1])
        
        let connectionsWithHangingNode: [[Int]] = [
            [0,2],
            [2,1],
            [2,4],
            [4,3]
        ]
        #expect(GearQuestion.perform(connections: connectionsWithHangingNode) == [3, 2])
    }
}
