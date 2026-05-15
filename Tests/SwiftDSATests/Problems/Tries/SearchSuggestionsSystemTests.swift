//
//  SearchSuggestionsSystemTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct SearchSuggestionsSystemTests {

    @Test func canonicalExample() async throws {
        let result = SearchSuggestionsSystem.perform(
            ["mobile", "mouse", "moneypot", "monitor", "mousepad"],
            "mouse"
        )
        #expect(result == [
            ["mobile", "moneypot", "monitor"],
            ["mobile", "moneypot", "monitor"],
            ["mouse", "mousepad"],
            ["mouse", "mousepad"],
            ["mouse", "mousepad"],
        ])
    }

    @Test func noMatchAfterDivergence() async throws {
        // After typing "z", nothing matches — and once you've diverged you
        // never match again, even if later characters happen to coincide.
        let result = SearchSuggestionsSystem.perform(
            ["havana"],
            "tatiana"
        )
        #expect(result == [
            [], [], [], [], [], [], [],
        ])
    }

    @Test func returnsLexicographicallySmallestThree() async throws {
        // Five candidates share prefix "pay"; we want the 3 lex-smallest.
        let result = SearchSuggestionsSystem.perform(
            ["payment", "paynow", "paylah", "payee", "paypal"],
            "pay"
        )
        #expect(result == [
            ["payee", "paylah", "payment"],  // after "p"
            ["payee", "paylah", "payment"],  // after "pa"
            ["payee", "paylah", "payment"],  // after "pay"
        ])
    }

    @Test func fewerThanThreeCandidates() async throws {
        let result = SearchSuggestionsSystem.perform(
            ["grab", "grabpay"],
            "gra"
        )
        #expect(result == [
            ["grab", "grabpay"],
            ["grab", "grabpay"],
            ["grab", "grabpay"],
        ])
    }

    @Test func exactMatchIncludedInSuggestions() async throws {
        let result = SearchSuggestionsSystem.perform(
            ["apple", "app", "application"],
            "app"
        )
        #expect(result == [
            ["app", "apple", "application"],
            ["app", "apple", "application"],
            ["app", "apple", "application"],
        ])
    }

    @Test func singleProduct() async throws {
        let result = SearchSuggestionsSystem.perform(
            ["singapore"],
            "sing"
        )
        #expect(result == [
            ["singapore"],
            ["singapore"],
            ["singapore"],
            ["singapore"],
        ])
    }

    @Test func searchWordLongerThanAnyProduct() async throws {
        // After typing past the product's length we should get [].
        let result = SearchSuggestionsSystem.perform(
            ["a"],
            "abc"
        )
        #expect(result == [
            ["a"],
            [],
            [],
        ])
    }
}
