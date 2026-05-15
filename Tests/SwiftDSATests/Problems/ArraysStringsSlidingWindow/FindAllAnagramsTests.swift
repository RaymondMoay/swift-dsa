//
//  FindAllAnagramsTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct FindAllAnagramsTests {

    @Test func canonicalExamples() async throws {
        #expect(FindAllAnagrams.perform("cbaebabacd", "abc") == [0, 6])
        #expect(FindAllAnagrams.perform("abab", "ab") == [0, 1, 2])
    }

    @Test func noMatch() async throws {
        #expect(FindAllAnagrams.perform("abcdef", "xyz") == [])
    }

    @Test func pLongerThanS() async throws {
        #expect(FindAllAnagrams.perform("a", "ab") == [])
    }

    @Test func entireStringIsAnagram() async throws {
        #expect(FindAllAnagrams.perform("abc", "cab") == [0])
    }

    @Test func overlappingMatches() async throws {
        // Every contiguous window of length 2 is an anagram of "aa".
        #expect(FindAllAnagrams.perform("aaaa", "aa") == [0, 1, 2])
    }

    @Test func duplicateLettersInP() async throws {
        // p = "aab" requires two a's and one b in the window.
        // s = "aabaabaa"
        // windows of length 3:
        //   "aab" idx 0 -> match
        //   "aba" idx 1 -> match (rearranged "aab")
        //   "baa" idx 2 -> match
        //   "aab" idx 3 -> match
        //   "aba" idx 4 -> match
        //   "baa" idx 5 -> match
        #expect(FindAllAnagrams.perform("aabaabaa", "aab") == [0, 1, 2, 3, 4, 5])
    }

    @Test func singleCharacter() async throws {
        #expect(FindAllAnagrams.perform("aaaa", "a") == [0, 1, 2, 3])
    }
}
