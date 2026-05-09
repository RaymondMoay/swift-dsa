//
//  IdempotencyKeyCacheAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

/// Reference implementation for `IdempotencyKeyCache`.
///
/// Same HashMap + Doubly Linked List shape as `MerchantMetadataCacheAnswers`,
/// with one extra public op: `invalidate(key:)`.
///
/// The reason `invalidate` is O(1):
///   - HashMap gives us the node pointer in O(1).
///   - Because the list is doubly linked, we can rewire `node.prev.next` and
///     `node.next.prev` without scanning from the head.
///   - We then drop the key from the map.
///
/// Sentinel head / tail nodes mean we never have to special-case "removing the
/// only node" or "removing the head/tail" — every real node always has a
/// non-nil prev and next.

final class IdempotencyKeyCacheAnswers {

    private final class CacheNode {
        let key: String
        var value: PaymentResponse
        var prev: CacheNode?
        var next: CacheNode?

        init(key: String, value: PaymentResponse) {
            self.key = key
            self.value = value
        }
    }

    private let capacity: Int
    private var storage: [String: CacheNode] = [:]
    private let head: CacheNode
    private let tail: CacheNode

    init(capacity: Int) {
        precondition(capacity > 0, "capacity must be > 0")
        self.capacity = capacity

        let placeholder = PaymentResponse.declined(reason: "__sentinel__")
        self.head = CacheNode(key: "__head__", value: placeholder)
        self.tail = CacheNode(key: "__tail__", value: placeholder)
        head.next = tail
        tail.prev = head
    }

    func record(key: String, response: PaymentResponse) {
        if let existing = storage[key] {
            existing.value = response
            moveToFront(existing)
            return
        }

        if storage.count >= capacity {
            evictLRU()
        }

        let node = CacheNode(key: key, value: response)
        storage[key] = node
        insertAtFront(node)
    }

    func lookup(key: String) -> PaymentResponse? {
        guard let node = storage[key] else { return nil }
        moveToFront(node)
        return node.value
    }

    func invalidate(key: String) {
        guard let node = storage[key] else { return }
        unlink(node)
        storage[key] = nil
    }

    // MARK: - DLL helpers

    private func insertAtFront(_ node: CacheNode) {
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
        guard let lru = tail.prev, lru !== head else { return }
        unlink(lru)
        storage[lru.key] = nil
    }
}
