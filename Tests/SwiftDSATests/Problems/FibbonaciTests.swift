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
        #expect(Fibbonaci.perform(80) == 23416728348467685)
        #expect(Fibbonaci.perform(5) == 5)
        #expect(Fibbonaci.perform(4) == 3)
        #expect(Fibbonaci.perform(3) == 2)
        #expect(Fibbonaci.perform(2) == 1)
        #expect(Fibbonaci.perform(1) == 1)
    }
}
