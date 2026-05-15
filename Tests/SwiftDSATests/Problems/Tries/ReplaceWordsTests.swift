//
//  ReplaceWordsTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct ReplaceWordsTests {

    @Test func canonicalExample() async throws {
        let result = ReplaceWords.perform(
            ["cat", "bat", "rat"],
            "the cattle was rattled by the battery"
        )
        #expect(result == "the cat was rat by the bat")
    }

    @Test func picksShortestRoot() async throws {
        // Both "a" and "app" are roots; the shortest wins.
        let result = ReplaceWords.perform(
            ["a", "app"],
            "apple"
        )
        #expect(result == "a")
    }

    @Test func noRootMatchesLeavesWordUnchanged() async throws {
        let result = ReplaceWords.perform(
            ["cat"],
            "the dog barked"
        )
        #expect(result == "the dog barked")
    }

    @Test func emptyDictionary() async throws {
        let result = ReplaceWords.perform(
            [],
            "hello there friend"
        )
        #expect(result == "hello there friend")
    }

    @Test func rootEqualToWord() async throws {
        // The word is itself the root; no replacement needed but the result
        // is still the root.
        let result = ReplaceWords.perform(
            ["cat"],
            "cat sat on mat"
        )
        #expect(result == "cat sat on mat")
    }

    @Test func paymentsThemedMerchantNormalisation() async throws {
        // Merchant strings get folded onto the shortest known merchant root —
        // exactly the "group spend by merchant" use case mentioned in the
        // problem header.
        let result = ReplaceWords.perform(
            ["starbucks", "ntuc", "grab"],
            "starbucks_sg_orchard ntuc_fairprice_amk grab_food_order"
        )
        #expect(result == "starbucks ntuc grab")
    }

    @Test func singleWord() async throws {
        let result = ReplaceWords.perform(
            ["help"],
            "helpful"
        )
        #expect(result == "help")
    }

    @Test func wordShorterThanAnyRoot() async throws {
        // Word "ca" is shorter than the root "cat" — no match, keep as-is.
        let result = ReplaceWords.perform(
            ["cat"],
            "ca"
        )
        #expect(result == "ca")
    }
}
