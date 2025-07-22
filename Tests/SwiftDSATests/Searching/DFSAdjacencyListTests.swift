//
//  DFSAdjacencyListTests.swift
//  SwiftDSA
//
//  Created by Ray on 30/6/25.
//

import Testing

@testable import SwiftDSA

struct DFSAdjacencyListTests {
    
    @Test func assert() async throws {
        let graph: [[GraphEdge]] = [
            [.init(to: 1, weight: 3), .init(to: 2, weight: 1)], // 0
            [.init(to: 0, weight: 5)], // 1
            [.init(to: 3, weight: 4)], // 2
            [.init(to: 1, weight: 1), .init(to: 4, weight: 2)], // 3
            [] // 4
        ]
        
        #expect(DFSAdjacencyList.perform(graph: graph, source: 0, needle: 4) == [0, 2, 3, 4])
        #expect(DFSAdjacencyList.perform(graph: graph, source: 1, needle: 4) == [1, 0, 2, 3, 4])
        #expect(DFSAdjacencyList.perform(graph: graph, source: 3, needle: 4) == [3, 4])
        #expect(DFSAdjacencyList.perform(graph: graph, source: 2, needle: 4) == [2, 3, 4])
        #expect(DFSAdjacencyList.perform(graph: graph, source: 4, needle: 4) == [4])
        #expect(DFSAdjacencyList.perform(graph: graph, source: 4, needle: 3) == nil)
    }
}
