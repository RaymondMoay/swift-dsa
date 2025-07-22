//
//  NumberOfIslandsTests.swift
//  SwiftDSA
//
//  Created by Ray on 2/7/25.
//

import Testing

@testable import SwiftDSA

struct NumberOfIslandsTests {
    
    @Test func assert() async throws {
        let map = [
            [0, 1, 0, 1, 0],
            [0, 0, 0, 1, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0],
        ]
        
        #expect(NumberOfIslands.perform(map: map) == 2)
    }
}
