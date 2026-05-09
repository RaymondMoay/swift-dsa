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
    
    class Node: Equatable {
        var key: String
        var value: MerchantMetadata
        var prev: Node?
        var next: Node?
        
        init(key: String, value: MerchantMetadata, prev: Node? = nil, next: Node? = nil) {
            self.key = key
            self.value = value
            self.prev = prev
            self.next = next
        }
        
        // MARK: - Equatable Conformance

        // Required for Hashable (Hashable inherits from Equatable):
        // Defines when two Node instances are considered equal.
        // Two nodes are equal if their 'value' properties are equal.
        // Similar to hashing, we don't compare 'next' or 'prev' here
        // to avoid structural comparison for individual node equality.
        static func == (lhs: Node, rhs: Node) -> Bool {
            return lhs.value == rhs.value
        }
    }
    
    let capacity: Int
    var length: Int = 0
    var head: Node? = nil
    var tail: Node? = nil
    var storage: [String: Node] = [:]

    init(capacity: Int) {
        self.capacity = capacity
    }

    func get(merchantId: String) -> MerchantMetadata? {
        guard let node = storage[merchantId] else { return nil }
        detach(node: node)
        prepend(node: node)
        return node.value
    }

    func put(merchantId: String, metadata: MerchantMetadata) {
        guard let node = storage[merchantId] else {
            let newNode = Node(key: merchantId, value: metadata)
            
            if length == capacity {
                evictCache()
                length -= 1
            }
            
            prepend(node: newNode)
            length += 1
            
            storage[newNode.key] = newNode
            return
        }
        
        node.value = metadata
        detach(node: node)
        prepend(node: node)
    }
    
    // Private helpers
    
    private func detach(node: Node) {
        if head == node {
            head = node.next
        }
        if tail == node {
            tail = node.prev
        }
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        node.prev = nil
        node.next = nil
    }
    
    private func prepend(node: Node) {
        guard let head else {
            head = node
            tail = node
            return
        }
        head.prev = node
        node.next = head
        self.head = node
    }
    
    private func evictCache() {
        guard let head, let tail else { return } // can't evict an empty cache
        
        storage[tail.key] = nil
        
        if head == tail {
            self.head = nil
        }
        tail.prev?.next = nil
        self.tail = tail.prev
    }
}
