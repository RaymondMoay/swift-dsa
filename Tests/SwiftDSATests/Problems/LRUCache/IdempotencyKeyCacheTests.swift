//
//  IdempotencyKeyCacheTests.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

import Testing

@testable import SwiftDSA

struct IdempotencyKeyCacheTests {

    @Test func missOnEmptyCache() {
        let cache = IdempotencyKeyCache(capacity: 3)
        #expect(cache.lookup(key: "uuid-A") == nil)
    }

    @Test func recordThenLookup() {
        let cache = IdempotencyKeyCache(capacity: 3)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        #expect(cache.lookup(key: "uuid-A") == .approved(amountCents: 1500))
    }

    @Test func recordOverwritesExistingKey() {
        let cache = IdempotencyKeyCache(capacity: 3)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.record(key: "uuid-A", response: .declined(reason: "fraud_flagged"))
        #expect(cache.lookup(key: "uuid-A") == .declined(reason: "fraud_flagged"))
    }

    @Test func evictsLRUWhenFull() {
        let cache = IdempotencyKeyCache(capacity: 2)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.record(key: "uuid-B", response: .declined(reason: "insufficient_funds"))

        // A is LRU. Recording C evicts A.
        cache.record(key: "uuid-C", response: .approved(amountCents: 4200))

        #expect(cache.lookup(key: "uuid-A") == nil)
        #expect(cache.lookup(key: "uuid-B") == .declined(reason: "insufficient_funds"))
        #expect(cache.lookup(key: "uuid-C") == .approved(amountCents: 4200))
    }

    @Test func lookupRefreshesRecency() {
        let cache = IdempotencyKeyCache(capacity: 2)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.record(key: "uuid-B", response: .declined(reason: "insufficient_funds"))

        // Touching A makes B the LRU.
        _ = cache.lookup(key: "uuid-A")

        cache.record(key: "uuid-C", response: .approved(amountCents: 4200))

        #expect(cache.lookup(key: "uuid-B") == nil)
        #expect(cache.lookup(key: "uuid-A") == .approved(amountCents: 1500))
        #expect(cache.lookup(key: "uuid-C") == .approved(amountCents: 4200))
    }

    @Test func invalidateRemovesEntry() {
        let cache = IdempotencyKeyCache(capacity: 3)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.invalidate(key: "uuid-A")
        #expect(cache.lookup(key: "uuid-A") == nil)
    }

    @Test func invalidateMissingKeyIsNoOp() {
        let cache = IdempotencyKeyCache(capacity: 3)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.invalidate(key: "uuid-DOES-NOT-EXIST")
        // Other entries unaffected.
        #expect(cache.lookup(key: "uuid-A") == .approved(amountCents: 1500))
    }

    @Test func invalidateFreesCapacity() {
        let cache = IdempotencyKeyCache(capacity: 2)
        cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
        cache.record(key: "uuid-B", response: .declined(reason: "insufficient_funds"))

        // Invalidate A — now there's room for C without evicting B.
        cache.invalidate(key: "uuid-A")
        cache.record(key: "uuid-C", response: .approved(amountCents: 4200))

        #expect(cache.lookup(key: "uuid-A") == nil)
        #expect(cache.lookup(key: "uuid-B") == .declined(reason: "insufficient_funds"))
        #expect(cache.lookup(key: "uuid-C") == .approved(amountCents: 4200))
    }

    @Test func invalidatingMiddleNodeKeepsListConsistent() {
        // This is the test that catches a broken DLL unlink: if invalidating a
        // middle node corrupts prev/next pointers, subsequent eviction or
        // lookup will misbehave.
        let cache = IdempotencyKeyCache(capacity: 3)
        cache.record(key: "uuid-A", response: .approved(amountCents: 100))
        cache.record(key: "uuid-B", response: .approved(amountCents: 200))
        cache.record(key: "uuid-C", response: .approved(amountCents: 300))

        // Order from MRU to LRU: C, B, A. Invalidate the middle one.
        cache.invalidate(key: "uuid-B")

        // Adding D should not evict anyone (we're at 2/3).
        cache.record(key: "uuid-D", response: .approved(amountCents: 400))

        #expect(cache.lookup(key: "uuid-A") == .approved(amountCents: 100))
        #expect(cache.lookup(key: "uuid-B") == nil)
        #expect(cache.lookup(key: "uuid-C") == .approved(amountCents: 300))
        #expect(cache.lookup(key: "uuid-D") == .approved(amountCents: 400))

        // Now we're at full capacity (3). Adding E should evict the LRU.
        // After the lookups above, MRU->LRU order is: D, C, A.  So A is LRU.
        cache.record(key: "uuid-E", response: .approved(amountCents: 500))
        #expect(cache.lookup(key: "uuid-A") == nil)
        #expect(cache.lookup(key: "uuid-C") == .approved(amountCents: 300))
        #expect(cache.lookup(key: "uuid-D") == .approved(amountCents: 400))
        #expect(cache.lookup(key: "uuid-E") == .approved(amountCents: 500))
    }
}
