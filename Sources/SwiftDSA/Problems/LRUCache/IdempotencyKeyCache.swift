//
//  IdempotencyKeyCache.swift
//  SwiftDSA
//
//  Created by Ray on 8/5/26.
//

/// # Problem: Idempotency Key Cache
///
/// When the Google Pay client submits a payment, it attaches an `Idempotency-Key`
/// header (a UUID generated before the first attempt). If the network drops the
/// response, the client retries with the SAME key. The server must NOT charge twice —
/// instead, it should return the response it already produced for that key.
///
/// You are building the in-memory layer of that server-side de-dup cache. The
/// authoritative store is in a database, but recently-seen keys are kept in this
/// fast in-memory cache to absorb retry storms without hitting the DB on every
/// retry.
///
/// The cache is bounded by capacity (e.g. 10,000 keys) and uses LRU eviction.
///
/// ## Required API
/// - `record(key:response:)`
///   - Stores the response for this idempotency key.
///   - Marks the entry as most-recently-used.
///   - If at capacity AND the key is new, evict the LRU entry first.
/// - `lookup(key:) -> PaymentResponse?`
///   - Returns the stored response if present (a "duplicate retry"), else nil.
///   - On a hit, marks the entry as most-recently-used.
/// - `invalidate(key:)`
///   - Removes the entry entirely. Used when the payment is REVERSED — we no
///     longer want a retry to be served the old "approved" response, because the
///     authoritative state has changed.
///   - No-op if the key is not in the cache.
///
/// ## Constraints
/// - All three operations must be O(1) average time.
/// - Capacity is fixed at init time and > 0.
///
/// ## Example
/// ```
/// let cache = IdempotencyKeyCache(capacity: 2)
/// cache.record(key: "uuid-A", response: .approved(amountCents: 1500))
/// cache.lookup(key: "uuid-A")            // .approved(...) — duplicate retry path
/// cache.record(key: "uuid-B", response: .declined(reason: "insufficient_funds"))
/// cache.lookup(key: "uuid-A")            // hit — uuid-A is now MRU again
/// cache.record(key: "uuid-C", response: .approved(amountCents: 4200))
/// // uuid-B was LRU, so it got evicted.
/// cache.lookup(key: "uuid-B")            // nil
///
/// // Now imagine the payment uuid-A gets reversed by ops:
/// cache.invalidate(key: "uuid-A")
/// cache.lookup(key: "uuid-A")            // nil — falls through to DB on next retry
/// ```
///
/// ## Interviewer hint (the "concept" they're checking for L4)
/// `invalidate` is the operation that proves you actually understand the doubly-
/// linked list. To remove an arbitrary node in O(1), you need pointers in BOTH
/// directions so you can rewire `prev.next` and `next.prev` without traversing.
/// A singly-linked list would force you to scan from the head — O(n).
///
/// Also: be ready to explain WHY this lives in front of a DB rather than replacing
/// it. The cache is for latency under retry storms; durability and audit still
/// require the DB.

enum PaymentResponse: Equatable {
    case approved(amountCents: Int)
    case declined(reason: String)
}

final class IdempotencyKeyCache {

    init(capacity: Int) {
        // TODO: implement
    }

    func record(key: String, response: PaymentResponse) {
        // TODO: implement
    }

    func lookup(key: String) -> PaymentResponse? {
        // TODO: implement
        return nil
    }

    func invalidate(key: String) {
        // TODO: implement
    }
}
