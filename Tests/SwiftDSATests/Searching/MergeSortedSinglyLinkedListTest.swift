//
//  MergeSortedSinglyLinkedListTest.swift
//  SwiftDSA
//
//  Created by Ray on 25/6/25.
//

import Testing

@testable import SwiftDSA

struct MergeSortedSinglyLinkedListTest {
    
    @Test func assert1() async throws {
        
        let rootA = Node(value: 1,
                         next: .init(value: 1,
                                     next: .init(value: 2,
                                                 next: .init(value: 6,
                                                             next: .init(value: 12, next: nil)))))
        let rootB = Node(value: 1,
                         next: .init(value: 1,
                                     next: .init(value: 7, next: nil)))
        
        MergeSortedSinglyLinkedList.perform(rootA: rootA, rootB: rootB)
        
        var result: [Int] = []
        asArray(curr: rootA, arr: &result)
        #expect(result == [1,1,1,1,2,6,7,12])
    }
    
    @Test func assert2() async throws {
        
        let rootA = Node(value: 1,
                         next: .init(value: 1,
                                     next: .init(value: 7, next: nil)))
        
        let rootB = Node(value: 1,
                         next: .init(value: 1,
                                     next: .init(value: 2,
                                                 next: .init(value: 6,
                                                             next: .init(value: 12, next: nil)))))
        
        MergeSortedSinglyLinkedList.perform(rootA: rootA, rootB: rootB)
        
        var result: [Int] = []
        asArray(curr: rootA, arr: &result)
        #expect(result == [1,1,1,1,2,6,7,12])
    }
    
    @Test func assert3() async throws {
        
        let rootA = Node(value: 1,
                         next: .init(value: 1,
                                     next: .init(value: 7, next: nil)))
        
        let rootB = Node(value: 9,
                         next: .init(value: 10,
                                     next: .init(value: 11,
                                                 next: .init(value: 20,
                                                             next: .init(value: 200, next: nil)))))
        
        MergeSortedSinglyLinkedList.perform(rootA: rootA, rootB: rootB)
        
        var result: [Int] = []
        asArray(curr: rootA, arr: &result)
        #expect(result == [1,1,7,9,10,11,20,200])
    }
}

private extension MergeSortedSinglyLinkedListTest {
    
    func asArray(curr: Node<Int>?, arr: inout [Int])  {
        guard let curr else { return }
        arr.append(curr.value)
        asArray(curr: curr.next, arr: &arr)
    }
}
