//
//  TopKFrequentElementsTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct TopKFrequentElementsTests {

    @Test func canonicalExample() async throws {
        let result = TopKFrequentElements.find([1, 1, 1, 2, 2, 3], k: 2)
        #expect(Set(result) == Set([1, 2]))
    }

    @Test func singleElement() async throws {
        #expect(TopKFrequentElements.find([1], k: 1) == [1])
    }

    @Test func kEqualsUniqueCount() async throws {
        let result = TopKFrequentElements.find([4, 1, -1, 2, -1, 2, 3], k: 5)
        #expect(Set(result) == Set([4, 1, -1, 2, 3]))
    }

    @Test func allSameFrequencyAnyKMatchesGuarantee() async throws {
        // The problem guarantees a unique answer. When every element has
        // frequency 1, that requires k == number of unique elements — here, k=4.
        let result = TopKFrequentElements.find([10, 20, 30, 40], k: 4)
        #expect(Set(result) == Set([10, 20, 30, 40]))
    }

    @Test func twoMostFrequentWithDistinctCounts() async throws {
        // Frequencies: 1->4, 2->3, 3->2, 4->1
        let nums = [1, 1, 1, 1, 2, 2, 2, 3, 3, 4]
        let result = TopKFrequentElements.find(nums, k: 2)
        #expect(Set(result) == Set([1, 2]))
    }

    @Test func threeMostFrequent() async throws {
        let nums = [5, 5, 5, 6, 6, 7, 7, 8]
        // Frequencies: 5->3, 6->2, 7->2, 8->1 — top 3 are {5,6,7}.
        let result = TopKFrequentElements.find(nums, k: 3)
        #expect(Set(result) == Set([5, 6, 7]))
    }

    @Test func negativeAndPositiveValues() async throws {
        let nums = [-1, -1, -1, 2, 2, 3]
        let result = TopKFrequentElements.find(nums, k: 2)
        #expect(Set(result) == Set([-1, 2]))
    }
}
