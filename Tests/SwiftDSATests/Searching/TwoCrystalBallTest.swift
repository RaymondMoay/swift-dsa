//
//  TwoCrystalBallTest.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Testing

@testable import SwiftDSA

struct TwoCrystalBallTest {
    
    @Test(arguments: [
        // Size 4 (sqrt = 2)
        ([false, false, false, false], -1),         // No breaking point
        ([false, false, true, true], 2),            // Breaks at index 2
        
        // Size 9 (sqrt = 3)
        ([false, false, false, false, false, false, false, false, false], -1), // No break
        ([false, false, false, true, true, true, true, true, true], 3),        // Breaks at index 3
        ([true, true, true, true, true, true, true, true, true], 0),           // Breaks at index 0
        
        // Size 16 (sqrt = 4)
        ([false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], -1), // No break
        ([false, false, false, false, false, false, true, true, true, true, true, true, true, true, true, true], 6),            // Breaks at index 6
        ([false, false, false, false, false, false, false, false, false, true, true, true, true, true, true, true], 9),         // Breaks at index 9
        
        // Size 25 (sqrt = 5)
        ([false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], -1), // No break
        ([false, false, false, false, false, false, false, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true], 8),                      // Breaks at index 8
        ([false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true], 1),                             // Breaks at index 1
    ])
    func assert(args: (
        array: [Bool],
        result: Int
    )) async throws {
        #expect(TwoCrystalBall.perform(breaks: args.array) == args.result)
    }
}
