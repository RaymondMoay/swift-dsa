//
//  BubbleSortTest.swift
//  SwiftDSA
//
//  Created by Ray on 17/6/25.
//

import Testing

@testable import SwiftDSA

struct BubbleSortTest {
    
    @Test(arguments: [
        // Edge cases
        ([], []),                           // Empty array
        ([1], [1]),                         // Single-element array

        // Already sorted array
        ([1, 2, 3, 4, 5], [1, 2, 3, 4, 5]),

        // Reverse sorted array (worst case)
        ([5, 4, 3, 2, 1], [1, 2, 3, 4, 5]),

        // Unsorted array
        ([3, 1, 4, 5, 2], [1, 2, 3, 4, 5]),

        // Duplicates
        ([4, 2, 4, 3, 2], [2, 2, 3, 4, 4]),

        // All same elements
        ([7, 7, 7, 7], [7, 7, 7, 7]),

        // Negative numbers
        ([-3, -1, -4, -2, 0], [-4, -3, -2, -1, 0]),

        // Mixed positive and negative
        ([3, -1, 4, -2, 0], [-2, -1, 0, 3, 4]),

        // Large values
        ([Int.max, 1, Int.min, 0], [Int.min, 0, 1, Int.max]),
    ])
    func assert(args: (
        array: [Int],
        result: [Int]
    )) async throws {
        #expect(BubbleSort.perform(array: args.array) == args.result)
    }
}
