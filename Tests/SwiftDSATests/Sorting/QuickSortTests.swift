//
//  QuickSortTests.swift
//  SwiftDSA
//
//  Created by Ray on 20/6/25.
//

import Testing

@testable import SwiftDSA

struct QuickSortTests {
    
    @Test
    func testQuickSort() {
        var arr = [9, 3, 7, 4, 69, 420, 42]
        QuickSort.perform(&arr)
        #expect(arr == [3, 4, 7, 9, 42, 69, 420])
    }
    
    @Test
    func testQuickSort2() {
        var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        QuickSort.perform(&arr)
        #expect(arr == [1, 2, 3, 4, 5, 6, 7, 8, 9]) // if we happen to select the last and the last is largest and array is sorted... it will run through the entire LHS for the pivoting...
    }
}
