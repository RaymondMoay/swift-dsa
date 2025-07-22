//
//  LRUCacheTests.swift
//  SwiftDSA
//
//  Created by Ray on 3/7/25.
//

import Testing

@testable import SwiftDSA

struct LRUCacheTests {
    
    @Test func assert() async throws {
        
        let lru = LRUCache<String, Int>(capacity: 3)
        
        #expect(lru.get(key: "foo") == nil)
        lru.update(key: "foo", value: 69)
        #expect(lru.get(key: "foo") == 69)
        
        lru.update(key: "bar", value: 420)
        #expect(lru.get(key: "bar") == 420)
        
        lru.update(key: "baz", value: 1337)
        #expect(lru.get(key: "baz") == 1337)
        
        lru.update(key: "ball", value: 69420)
        #expect(lru.get(key: "ball") == 69420)
        #expect(lru.get(key: "foo") == nil)
        #expect(lru.get(key: "bar") == 420)
        lru.update(key: "foo", value: 69)
        #expect(lru.get(key: "bar") == 420)
        #expect(lru.get(key: "foo") == 69)
        
        // shouldn't of been deleted, but since bar was get'd, bar was added to the
        // front of the list, so baz became the end
        #expect(lru.get(key: "baz") == nil)
    }
}
