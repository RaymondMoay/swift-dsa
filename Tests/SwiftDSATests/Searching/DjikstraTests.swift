//
//  DjikstraTests.swift
//  SwiftDSA
//
//  Created by Ray on 1/7/25.
//

import Testing

@testable import SwiftDSA

struct DjikstraTests {
    
    @Test func assert() async throws {
        let graph: [[GraphEdge]] = [
            [.init(to: 1, weight: 1), .init(to: 2, weight: 5)], // 0
            [.init(to: 2, weight: 7), .init(to: 3, weight: 6)], // 1
            [.init(to: 4, weight: 1)], // 2
            [.init(to: 2, weight: 1)], // 3
            [] // 4
        ]
        
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 4) == [0,2,4])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 3) == [0,1,3])
        #expect(Dijkstra.perform(graph: graph, source: 0, sink: 2) == [0,2])
    }
}

