//
//  MerchantMetadataCache.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

/// # Problem: Merchant Metadata Cache
///
/// You are building the transaction history feed for Google Pay. Each transaction row
/// shows a merchant logo and display name. The merchant metadata is fetched from a
/// backend service — calling it on every cell render is too slow and burns battery.
///
/// Build an in-memory cache that the feed can hit synchronously. The cache has a
/// fixed capacity (e.g. 200 merchants). When it is full, the least-recently-used
/// entry should be evicted to make room for a new one.
///
/// ## Why an LRU eviction policy?
/// - A user typically scrolls a small set of recent merchants repeatedly (Starbucks,
///   their grocery store, transit). Those should stay hot.
/// - One-off merchants (a one-time online order from 6 months ago) can be evicted
///   without harming the common case.
///
/// ## Required API
/// - `get(merchantId:) -> MerchantMetadata?`
///   - Returns the cached metadata if present, otherwise nil.
///   - On a hit, the entry becomes the most-recently-used.
/// - `put(merchantId:metadata:)`
///   - Inserts or updates the entry, makes it the most-recently-used.
///   - If the cache is at capacity AND the key is new, evict the LRU entry first.
///
/// ## Constraints
/// - `get` and `put` must both be O(1) average time.
/// - Capacity is fixed at init time and > 0.
///
/// ## Example
/// ```
/// let cache = MerchantMetadataCache(capacity: 2)
/// cache.put(merchantId: "starbucks_sg", metadata: .init(name: "Starbucks", logoURL: "..."))
/// cache.put(merchantId: "ntuc_sg",      metadata: .init(name: "NTUC FairPrice", logoURL: "..."))
/// cache.get(merchantId: "starbucks_sg")  // hit — starbucks is now MRU
/// cache.put(merchantId: "grab_sg",      metadata: .init(name: "Grab", logoURL: "..."))
/// // ntuc_sg was the LRU at this point, so it gets evicted.
/// cache.get(merchantId: "ntuc_sg")       // nil
/// cache.get(merchantId: "starbucks_sg")  // hit
/// cache.get(merchantId: "grab_sg")       // hit
/// ```
///
/// ## Interviewer hint (the "concept" they're checking for L4)
/// You should be able to explain WHY a HashMap alone is not enough (it gives O(1)
/// lookup but no ordering / no O(1) eviction of the LRU), and WHY a doubly-linked
/// list alone is not enough (O(n) lookup). The combination gives you O(1) on both.

struct MerchantMetadata: Equatable {
    let name: String
    let logoURL: String
}

final class MerchantMetadataCache {

    init(capacity: Int) {
        // TODO: implement
    }

    func get(merchantId: String) -> MerchantMetadata? {
        // TODO: implement
        return nil
    }

    func put(merchantId: String, metadata: MerchantMetadata) {
        // TODO: implement
    }
}
