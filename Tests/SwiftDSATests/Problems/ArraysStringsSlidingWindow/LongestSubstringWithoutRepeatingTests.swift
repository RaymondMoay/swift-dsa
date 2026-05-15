//
//  LongestSubstringWithoutRepeatingTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct LongestSubstringWithoutRepeatingTests {

    @Test func empty() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("") == 0)
    }

    @Test func singleCharacter() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("a") == 1)
    }

    @Test func allUnique() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("abcdef") == 6)
    }

    @Test func allSame() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("bbbbb") == 1)
    }

    @Test func canonicalExamples() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("abcabcbb") == 3)
        #expect(LongestSubstringWithoutRepeating.perform("pwwkew") == 3)
    }

    @Test func mixedCharacters() async throws {
        #expect(LongestSubstringWithoutRepeating.perform("dvdf") == 3) // "vdf"
        #expect(LongestSubstringWithoutRepeating.perform("anviaj") == 5) // "nviaj"
        #expect(LongestSubstringWithoutRepeating.perform(" ") == 1)
        #expect(LongestSubstringWithoutRepeating.perform("au") == 2)
    }

    @Test func duplicateOutsideWindowDoesNotResetLeft() async throws {
        // "tmmzuxt" — when the trailing 't' is reached, the previous 't'
        // is at index 0 which is already left of the current window.
        #expect(LongestSubstringWithoutRepeating.perform("tmmzuxt") == 5)
    }
}
