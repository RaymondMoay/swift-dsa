//
//  BinarySearchTest.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Testing

@testable import SwiftDSA

struct BinarySearchTest {
    
    @Test(arguments: [
        // Edge cases
        ([], 1, false),                           // Empty array
        ([5], 5, true),                           // Single-element, present
        ([5], 3, false),                          // Single-element, absent

        // Basic position checks
        ([1, 3, 5, 7, 9], 1, true),               // First element
        ([1, 3, 5, 7, 9], 5, true),               // Middle element
        ([1, 3, 5, 7, 9], 9, true),               // Last element
        ([1, 3, 5, 7, 9], 6, false),              // Missing element (in between)

        // Even-sized array
        ([2, 4, 6, 8, 10, 12], 8, true),          // Middle-right element
        ([2, 4, 6, 8, 10, 12], 11, false),        // Missing element (between 10 and 12)

        // Odd-sized array
        ([2, 4, 6, 8, 10], 8, true),              // Middle element

        // Duplicates
        ([1, 2, 2, 2, 3, 4], 2, true),            // Duplicated value, present
        ([1, 2, 2, 2, 3, 4], 5, false),           // Missing value, with duplicates in array

        // Negative numbers
        ([-10, -5, 0, 5, 10], -5, true),          // Negative number, present
        ([-10, -5, 0, 5, 10], -6, false),         // Negative number, missing

        // Large numbers
        ([Int.min, -1000000, 0, 1000000, Int.max], Int.max, true),   // Search for largest Int
        ([Int.min, -1000000, 0, 1000000, Int.max], Int.min, true),   // Search for smallest Int
        ([Int.min, -1000000, 0, 1000000, Int.max], 1, false),        // Search for missing value
    ])
    func assert(args: (
        array: [Int],
        value: Int,
        result: Bool
    )) async throws {
        #expect(BinarySearch.perform(array: args.array, value: args.value) == args.result)
    }
}
