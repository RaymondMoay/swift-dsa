//
//  MerchantMetadataCacheTests.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

import Testing

@testable import SwiftDSA

struct MerchantMetadataCacheTests {

    private func meta(_ name: String) -> MerchantMetadata {
        MerchantMetadata(name: name, logoURL: "https://logos.example/\(name).png")
    }

    @Test func missOnEmptyCache() {
        let cache = MerchantMetadataCache(capacity: 3)
        #expect(cache.get(merchantId: "starbucks_sg") == nil)
    }

    @Test func putThenGetReturnsValue() {
        let cache = MerchantMetadataCache(capacity: 3)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        #expect(cache.get(merchantId: "starbucks_sg") == meta("Starbucks"))
    }

    @Test func putUpdatesExistingKey() {
        let cache = MerchantMetadataCache(capacity: 3)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks Reserve"))
        #expect(cache.get(merchantId: "starbucks_sg") == meta("Starbucks Reserve"))
    }

    @Test func evictsLeastRecentlyUsedWhenFull() {
        let cache = MerchantMetadataCache(capacity: 2)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        cache.put(merchantId: "ntuc_sg",      metadata: meta("NTUC FairPrice"))

        // ntuc is MRU, starbucks is LRU. Adding grab evicts starbucks.
        cache.put(merchantId: "grab_sg", metadata: meta("Grab"))

        #expect(cache.get(merchantId: "starbucks_sg") == nil)
        #expect(cache.get(merchantId: "ntuc_sg") == meta("NTUC FairPrice"))
        #expect(cache.get(merchantId: "grab_sg") == meta("Grab"))
    }

    @Test func getRefreshesRecency() {
        let cache = MerchantMetadataCache(capacity: 2)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        cache.put(merchantId: "ntuc_sg",      metadata: meta("NTUC FairPrice"))

        // touching starbucks makes ntuc the LRU.
        _ = cache.get(merchantId: "starbucks_sg")

        cache.put(merchantId: "grab_sg", metadata: meta("Grab"))

        #expect(cache.get(merchantId: "ntuc_sg") == nil)
        #expect(cache.get(merchantId: "starbucks_sg") == meta("Starbucks"))
        #expect(cache.get(merchantId: "grab_sg") == meta("Grab"))
    }

    @Test func updatingExistingKeyDoesNotEvict() {
        let cache = MerchantMetadataCache(capacity: 2)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        cache.put(merchantId: "ntuc_sg",      metadata: meta("NTUC FairPrice"))

        // updating an existing key should NOT trigger eviction — count stays at 2.
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks Reserve"))

        #expect(cache.get(merchantId: "starbucks_sg") == meta("Starbucks Reserve"))
        #expect(cache.get(merchantId: "ntuc_sg") == meta("NTUC FairPrice"))
    }

    @Test func capacityOfOneEvictsImmediately() {
        let cache = MerchantMetadataCache(capacity: 1)
        cache.put(merchantId: "starbucks_sg", metadata: meta("Starbucks"))
        cache.put(merchantId: "ntuc_sg",      metadata: meta("NTUC FairPrice"))

        #expect(cache.get(merchantId: "starbucks_sg") == nil)
        #expect(cache.get(merchantId: "ntuc_sg") == meta("NTUC FairPrice"))
    }
}
