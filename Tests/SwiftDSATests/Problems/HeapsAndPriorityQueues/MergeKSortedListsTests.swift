//
//  MergeKSortedListsTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct MergeKSortedListsTests {

    @Test func canonicalExample() async throws {
        let lists: [ListNode?] = [
            ListNode.from([1, 4, 5]),
            ListNode.from([1, 3, 4]),
            ListNode.from([2, 6]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [1, 1, 2, 3, 4, 4, 5, 6])
    }

    @Test func emptyInputArray() async throws {
        #expect(MergeKSortedLists.merge([]) == nil)
    }

    @Test func allInputListsNil() async throws {
        #expect(MergeKSortedLists.merge([nil, nil, nil]) == nil)
    }

    @Test func someListsNil() async throws {
        let lists: [ListNode?] = [
            nil,
            ListNode.from([1, 2, 3]),
            nil,
            ListNode.from([0, 4]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [0, 1, 2, 3, 4])
    }

    @Test func singleListReturnedAsIs() async throws {
        let lists: [ListNode?] = [ListNode.from([1, 2, 3])]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [1, 2, 3])
    }

    @Test func singleElementLists() async throws {
        let lists: [ListNode?] = [
            ListNode.from([5]),
            ListNode.from([1]),
            ListNode.from([3]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [1, 3, 5])
    }

    @Test func duplicatesAcrossLists() async throws {
        let lists: [ListNode?] = [
            ListNode.from([1, 1, 1]),
            ListNode.from([1, 1]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [1, 1, 1, 1, 1])
    }

    @Test func negativeValues() async throws {
        let lists: [ListNode?] = [
            ListNode.from([-10, -5, 0]),
            ListNode.from([-7, -3, 2]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [-10, -7, -5, -3, 0, 2])
    }

    @Test func unevenListLengths() async throws {
        let lists: [ListNode?] = [
            ListNode.from([1]),
            ListNode.from([2, 3, 4, 5, 6, 7, 8]),
            ListNode.from([0, 9]),
        ]
        let merged = MergeKSortedLists.merge(lists)
        #expect(merged?.toArray() == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
}
