//
//  PayeeAutocompleteCacheTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct PayeeAutocompleteCacheTests {

    @Test func emptyCacheReturnsNoSuggestions() async throws {
        let cache = PayeeAutocompleteCache()
        #expect(cache.suggest(prefix: "a", limit: 5) == [])
        #expect(cache.suggest(prefix: "", limit: 5) == [])
    }

    @Test func canonicalExample() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "mum")
        cache.record(payeeName: "mum")
        cache.record(payeeName: "marcus")
        cache.record(payeeName: "ming")

        // mum (freq 2) beats marcus and ming (freq 1).
        // Ties between marcus and ming resolved lexicographically.
        #expect(cache.suggest(prefix: "m", limit: 3) == ["mum", "marcus", "ming"])
    }

    @Test func suggestRespectsPrefix() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "mum")
        cache.record(payeeName: "marcus")

        #expect(cache.suggest(prefix: "mu", limit: 5) == ["mum"])
        #expect(cache.suggest(prefix: "ma", limit: 5) == ["marcus"])
        #expect(cache.suggest(prefix: "z", limit: 5) == [])
    }

    @Test func suggestRespectsLimit() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "anna")
        cache.record(payeeName: "anton")
        cache.record(payeeName: "alice")
        cache.record(payeeName: "amy")

        // All four match prefix "a"; limit caps the result.
        let top2 = cache.suggest(prefix: "a", limit: 2)
        #expect(top2.count == 2)
        // All frequencies are 1, so ties resolve lex asc → ["alice", "amy"].
        #expect(top2 == ["alice", "amy"])
    }

    @Test func limitZeroReturnsEmpty() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "alice")
        #expect(cache.suggest(prefix: "a", limit: 0) == [])
    }

    @Test func frequencyOrderingBeatsLexicographic() async throws {
        let cache = PayeeAutocompleteCache()
        // "zoe" is alphabetically last, but you pay her every week.
        cache.record(payeeName: "alice")
        for _ in 0..<5 { cache.record(payeeName: "zoe") }
        cache.record(payeeName: "bob")

        #expect(cache.suggest(prefix: "", limit: 3) == ["zoe", "alice", "bob"])
    }

    @Test func emptyPrefixReturnsAllPayees() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "alice")
        cache.record(payeeName: "bob")
        cache.record(payeeName: "carol")

        let result = cache.suggest(prefix: "", limit: 10)
        #expect(Set(result) == Set(["alice", "bob", "carol"]))
        // With equal frequencies, lex order is deterministic.
        #expect(result == ["alice", "bob", "carol"])
    }

    @Test func payeeIsPrefixOfAnotherPayee() async throws {
        let cache = PayeeAutocompleteCache()
        // Both "anna" and "annabelle" are real payees.
        cache.record(payeeName: "anna")
        cache.record(payeeName: "anna")
        cache.record(payeeName: "annabelle")

        let result = cache.suggest(prefix: "ann", limit: 5)
        #expect(result == ["anna", "annabelle"])
    }

    @Test func recordingTheSamePayeeIncrementsFrequency() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "ray")
        cache.record(payeeName: "raymond")
        cache.record(payeeName: "ray")
        cache.record(payeeName: "ray")

        // "ray" recorded 3x, "raymond" recorded 1x.
        #expect(cache.suggest(prefix: "r", limit: 5) == ["ray", "raymond"])
    }

    @Test func prefixLongerThanAnyPayeeReturnsEmpty() async throws {
        let cache = PayeeAutocompleteCache()
        cache.record(payeeName: "mum")
        #expect(cache.suggest(prefix: "mummy", limit: 5) == [])
    }
}
