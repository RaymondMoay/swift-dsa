//
//  MinimumWindowSubstringTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct MinimumWindowSubstringTests {

    @Test func canonicalExample() async throws {
        #expect(MinimumWindowSubstring.perform("ADOBECODEBANC", "ABC") == "BANC")
    }

    @Test func singleCharMatch() async throws {
        #expect(MinimumWindowSubstring.perform("a", "a") == "a")
    }

    @Test func tLongerThanS() async throws {
        #expect(MinimumWindowSubstring.perform("a", "aa") == "")
    }

    @Test func noValidWindow() async throws {
        #expect(MinimumWindowSubstring.perform("abc", "xyz") == "")
    }

    @Test func duplicatesInT() async throws {
        // Need two 'a's and one 'b'. Smallest window: "aab".
        #expect(MinimumWindowSubstring.perform("aaflslflsldkalskaaa", "aaa") == "aaa")
        #expect(MinimumWindowSubstring.perform("aaab", "aab") == "aab")
    }

    @Test func entireStringIsAnswer() async throws {
        #expect(MinimumWindowSubstring.perform("abc", "cba") == "abc")
    }

    @Test func caseSensitive() async throws {
        // Lowercase 'a' should not satisfy uppercase 'A'.
        #expect(MinimumWindowSubstring.perform("a", "A") == "")
    }

    @Test func picksFirstMinimumOnTie() async throws {
        // Two valid windows of length 3: "abc" (idx 0) and "abc" (idx 4).
        // The algorithm should return the earliest minimal window.
        #expect(MinimumWindowSubstring.perform("abcxyabc", "abc") == "abc")
    }
}
