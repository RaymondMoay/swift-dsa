//
//  MerchantMetadataCacheAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

/// Reference implementation for `MerchantMetadataCache`.
///
/// Data structure: HashMap + Doubly Linked List.
///
/// - HashMap[merchantId] -> node, gives O(1) lookup of a node by key.
/// - Doubly linked list maintains recency order. Head = MRU, tail = LRU.
///   The "doubly" part is what lets us unlink a node in O(1) when we touch it
///   (we have a pointer to its prev and next).
///
/// On `get`: look up the node in the map, unlink it from its current spot,
/// re-insert at head. Return its value.
///
/// On `put`:
///   - If the key already exists: update value, move node to head.
///   - Else if at capacity: evict tail (LRU), drop it from the map, then insert at head.
///   - Else: just insert at head.
///
/// Sentinel head and tail nodes remove a lot of nil-handling. Without them,
/// inserting into an empty list and removing the only node both need special cases.

final class MerchantMetadataCacheAnswers {

    private final class CacheNode {
        let key: String
        var value: MerchantMetadata
        var prev: CacheNode?
        var next: CacheNode?

        init(key: String, value: MerchantMetadata) {
            self.key = key
            self.value = value
        }
    }

    private let capacity: Int
    private var storage: [String: CacheNode] = [:]

    // Sentinels: head.next is the MRU, tail.prev is the LRU.
    // The sentinels themselves never hold real data.
    private let head: CacheNode
    private let tail: CacheNode

    init(capacity: Int) {
        precondition(capacity > 0, "capacity must be > 0")
        self.capacity = capacity

        let placeholder = MerchantMetadata(name: "", logoURL: "")
        self.head = CacheNode(key: "__head__", value: placeholder)
        self.tail = CacheNode(key: "__tail__", value: placeholder)
        head.next = tail
        tail.prev = head
    }

    func get(merchantId: String) -> MerchantMetadata? {
        guard let node = storage[merchantId] else { return nil }
        moveToFront(node)
        return node.value
    }

    func put(merchantId: String, metadata: MerchantMetadata) {
        if let existing = storage[merchantId] {
            existing.value = metadata
            moveToFront(existing)
            return
        }

        if storage.count >= capacity {
            evictLRU()
        }

        let node = CacheNode(key: merchantId, value: metadata)
        storage[merchantId] = node
        insertAtFront(node)
    }

    // MARK: - DLL helpers

    private func insertAtFront(_ node: CacheNode) {
        // head <-> node <-> head.next
        let first = head.next
        node.prev = head
        node.next = first
        head.next = node
        first?.prev = node
    }

    private func unlink(_ node: CacheNode) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.prev = nil
        node.next = nil
    }

    private func moveToFront(_ node: CacheNode) {
        unlink(node)
        insertAtFront(node)
    }

    private func evictLRU() {
        // tail.prev is LRU; if it's the head sentinel, the cache is empty.
        guard let lru = tail.prev, lru !== head else { return }
        unlink(lru)
        storage[lru.key] = nil
    }
}
