//
//  FibbonaciTests.swift
//  SwiftDSA
//
//  Created by Ray on 27/6/25.
//

import Testing

@testable import SwiftDSA

struct FibbonaciTests {
    
    @Test func assert() async throws {
        #expect(Fibbonaci.performTopDown(80) == 23416728348467685)
        #expect(Fibbonaci.performTopDown(5) == 5)
        #expect(Fibbonaci.performTopDown(4) == 3)
        #expect(Fibbonaci.performTopDown(3) == 2)
        #expect(Fibbonaci.performTopDown(2) == 1)
        #expect(Fibbonaci.performTopDown(1) == 1)
    }
    
    @Test func assertIterative() async throws {
        #expect(Fibbonaci.performBottomUpWithTabulation(80) == 23416728348467685)
        #expect(Fibbonaci.performBottomUpWithTabulation(5) == 5)
        #expect(Fibbonaci.performBottomUpWithTabulation(4) == 3)
        #expect(Fibbonaci.performBottomUpWithTabulation(3) == 2)
        #expect(Fibbonaci.performBottomUpWithTabulation(2) == 1)
        #expect(Fibbonaci.performBottomUpWithTabulation(1) == 1)
    }
    
    @Test func assertNoMemory() async throws {
        #expect(Fibbonaci.performNoMemory(80) == 23416728348467685)
        #expect(Fibbonaci.performNoMemory(5) == 5)
        #expect(Fibbonaci.performNoMemory(4) == 3)
        #expect(Fibbonaci.performNoMemory(3) == 2)
        #expect(Fibbonaci.performNoMemory(2) == 1)
        #expect(Fibbonaci.performNoMemory(1) == 1)
    }
}
