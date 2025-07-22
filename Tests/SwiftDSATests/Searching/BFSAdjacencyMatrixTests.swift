//
//  BFSAdjacencyMatrixTests.swift
//  SwiftDSA
//
//  Created by Ray on 29/6/25.
//

import Testing

@testable import SwiftDSA

struct BFSAdjacencyMatrixTests {
    
    @Test func assert() async throws {
        let graph: [[Int]] = [
            [0,3,1,0,0], // 0
            [5,0,0,0,0], // 1
            [0,0,0,4,0], // 2
            [0,1,0,0,2], // 3
            [0,0,0,0,0], // 4
        ]
        
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 0, needle: 4) == [0, 2, 3, 4])
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 1, needle: 4) == [1, 0, 2, 3, 4])
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 3, needle: 4) == [3, 4])
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 2, needle: 4) == [2, 3, 4])
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 4, needle: 4) == [])
        #expect(BFSAdjacencyMatrix.perform(graph: graph, source: 4, needle: 3) == [])
    }
}
