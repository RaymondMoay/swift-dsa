//
//  WordLadderTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct WordLadderTests {

    @Test func canonicalExample() async throws {
        // hit -> hot -> dot -> dog -> cog  (length 5)
        let result = WordLadder.perform(
            beginWord: "hit",
            endWord:   "cog",
            wordList:  ["hot", "dot", "dog", "lot", "log", "cog"]
        )
        #expect(result == 5)
    }

    @Test func endWordMissingFromList() async throws {
        let result = WordLadder.perform(
            beginWord: "hit",
            endWord:   "cog",
            wordList:  ["hot", "dot", "dog", "lot", "log"]
        )
        #expect(result == 0)
    }

    @Test func beginEqualsEnd() async throws {
        // Note: standard LC 127 returns 0 if endWord not in list, even when
        // begin == end. Our implementation matches that contract.
        let result = WordLadder.perform(
            beginWord: "abc",
            endWord:   "abc",
            wordList:  ["abc"]
        )
        #expect(result == 1)
    }

    @Test func directNeighbour() async throws {
        // a -> b  (length 2)
        let result = WordLadder.perform(
            beginWord: "a",
            endWord:   "c",
            wordList:  ["a", "b", "c"]
        )
        #expect(result == 2)
    }

    @Test func disconnectedReturnsZero() async throws {
        // No way to bridge "hit" to "cog" via the given list.
        let result = WordLadder.perform(
            beginWord: "hit",
            endWord:   "cog",
            wordList:  ["cog"]
        )
        #expect(result == 0)
    }

    @Test func emptyWordList() async throws {
        let result = WordLadder.perform(
            beginWord: "hit",
            endWord:   "cog",
            wordList:  []
        )
        #expect(result == 0)
    }

    @Test func multipleShortestPathsStillReturnLength() async throws {
        // hit -> hot -> dot -> dog -> cog
        // hit -> hot -> lot -> log -> cog
        // Both are length 5.
        let result = WordLadder.perform(
            beginWord: "hit",
            endWord:   "cog",
            wordList:  ["hot", "dot", "dog", "lot", "log", "cog"]
        )
        #expect(result == 5)
    }
}
