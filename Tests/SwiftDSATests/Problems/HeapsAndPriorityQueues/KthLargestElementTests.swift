//
//  KthLargestElementTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct KthLargestElementTests {

    @Test func canonicalExample() async throws {
        #expect(KthLargestElement.find([3, 2, 1, 5, 6, 4], k: 2) == 5)
    }

    @Test func canonicalExampleWithDuplicates() async throws {
        // kth largest in *sorted order* — duplicates count.
        #expect(KthLargestElement.find([3, 2, 3, 1, 2, 4, 5, 5, 6], k: 4) == 4)
    }

    @Test func kEqualsOneReturnsMax() async throws {
        #expect(KthLargestElement.find([7, 10, 4, 3, 20, 15], k: 1) == 20)
    }

    @Test func kEqualsCountReturnsMin() async throws {
        #expect(KthLargestElement.find([7, 10, 4, 3, 20, 15], k: 6) == 3)
    }

    @Test func singleElementArray() async throws {
        #expect(KthLargestElement.find([42], k: 1) == 42)
    }

    @Test func negativeValues() async throws {
        #expect(KthLargestElement.find([-1, -2, -3, -4, -5], k: 2) == -2)
    }

    @Test func mixedSigns() async throws {
        #expect(KthLargestElement.find([-1, 0, 1, -2, 2], k: 3) == 0)
    }

    @Test func allEqualValues() async throws {
        #expect(KthLargestElement.find([5, 5, 5, 5, 5], k: 3) == 5)
    }
}
