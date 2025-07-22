//
//  LinearSearchTest.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Testing

@testable import SwiftDSA

struct LinearSearchTest {
    
    @Test(arguments: [
        // Basic cases
        ([1, 2, 3, 4, 5, 6], 5, true),
        ([1, 2, 3, 4, 5, 6], 9, false),
        
        // Edge cases
        ([], 1, false),                           // Empty array
        ([1], 1, true),                           // Single-element array, present
        ([1], 2, false),                          // Single-element array, not present
        
        // Value at beginning, middle, end
        ([10, 20, 30, 40, 50], 10, true),         // First element
        ([10, 20, 30, 40, 50], 30, true),         // Middle element
        ([10, 20, 30, 40, 50], 50, true),         // Last element
        
        // Duplicates
        ([7, 7, 7, 7, 7], 7, true),               // All elements the same and matching
        ([7, 7, 7, 7, 7], 8, false),              // All elements the same but not matching
        ([1, 2, 2, 2, 3], 2, true),               // Multiple duplicates, present
        ([1, 2, 2, 2, 3], 4, false),              // Multiple duplicates, absent
        
        // Negative numbers
        ([-3, -2, -1, 0, 1, 2, 3], -2, true),     // Negative number, present
        ([-3, -2, -1, 0, 1, 2, 3], -4, false),    // Negative number, absent
        
        // Large number
        ([Int.max - 1, Int.max], Int.max, true),  // Large integer, present
        ([Int.min, Int.min + 1], Int.max, false), // Large integer, absent
        
        // Reversed order
        ([6, 5, 4, 3, 2, 1], 4, true),            // Not sorted ascending
        ([6, 5, 4, 3, 2, 1], 7, false),           // Not sorted ascending, missing
    ])
    func assert(args: (
        array: [Int],
        value: Int,
        result: Bool
    )) async throws {
        #expect(LinearSearch.perform(array: args.array, value: args.value) == args.result)
    }
}
