//
//  TrieTests.swift
//  SwiftDSA
//
//  Created by Ray on 6/5/26.
//

import Testing

@testable import SwiftDSA

struct TrieTests {

    // MARK: - insert

    @Test
    func insertSingleWord() {
        let trie = Trie()
        trie.insert(word: "apple")
        #expect(trie.search(prefix: "apple"))
    }

    @Test
    func insertCreatesIntermediateNodes() {
        let trie = Trie()
        trie.insert(word: "apple")
        // intermediate prefix path exists
        #expect(trie.search(prefix: "app"))
    }

    @Test
    func insertSharedPrefix() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        #expect(trie.search(prefix: "app"))
        #expect(trie.search(prefix: "apple"))
    }

    @Test
    func insertMultipleDistinctWords() {
        let trie = Trie()
        trie.insert(word: "cat")
        trie.insert(word: "car")
        trie.insert(word: "dog")
        #expect(trie.search(prefix: "cat"))
        #expect(trie.search(prefix: "car"))
        #expect(trie.search(prefix: "dog"))
    }

    @Test
    func insertSingleCharWord() {
        let trie = Trie()
        trie.insert(word: "a")
        #expect(trie.search(prefix: "a"))
    }

    // MARK: - search

    @Test
    func searchReturnsTrueForInsertedWord() {
        let trie = Trie()
        trie.insert(word: "hello")
        #expect(trie.search(prefix: "hello"))
    }

    @Test
    func searchReturnsTrueForPrefixOfInsertedWord() {
        let trie = Trie()
        trie.insert(word: "hello")
        #expect(trie.search(prefix: "hel"))
    }

    @Test
    func searchReturnsFalseForAbsentWord() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(!trie.search(prefix: "bat"))
    }

    @Test
    func searchReturnsFalseForExtensionBeyondInsertedWord() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(!trie.search(prefix: "cats"))
    }

    // MARK: - autocomplete

    @Test
    func autocompleteReturnsAllWordsWithPrefix() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        trie.insert(word: "application")
        trie.insert(word: "banana")

        let results = trie.autocomplete("app").sorted()
        #expect(results == ["app", "apple", "application"])
    }

    @Test
    func autocompleteIncludesPrefixItselfWhenItIsAWord() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")

        let results = trie.autocomplete("app").sorted()
        #expect(results == ["app", "apple"])
    }

    @Test
    func autocompleteReturnsEmptyForUnknownPrefix() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(trie.autocomplete("dog") == [])
    }

    @Test
    func autocompleteReturnsExactWordWhenNoExtensions() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(trie.autocomplete("cat") == ["cat"])
    }

    // MARK: - contains

    @Test
    func containsReturnsTrueForInsertedWord() {
        let trie = Trie()
        trie.insert(word: "apple")
        #expect(trie.contains(word: "apple"))
    }

    @Test
    func containsReturnsFalseForPrefixOnly() {
        let trie = Trie()
        trie.insert(word: "apple")
        // "app" was never inserted — it's only an intermediate node
        #expect(!trie.contains(word: "app"))
    }

    @Test
    func containsReturnsFalseForAbsentWord() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(!trie.contains(word: "bat"))
    }

    @Test
    func containsReturnsFalseForExtensionBeyondInsertedWord() {
        let trie = Trie()
        trie.insert(word: "cat")
        #expect(!trie.contains(word: "cats"))
    }

    @Test
    func containsDistinguishesBetweenPrefixAndWord() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        #expect(trie.contains(word: "app"))
        #expect(trie.contains(word: "apple"))
    }

    // MARK: - delete

    @Test
    func deleteRemovesWord() {
        let trie = Trie()
        trie.insert(word: "cat")
        trie.delete(word: "cat")
        #expect(!trie.contains(word: "cat"))
    }

    @Test
    func deleteDoesNotAffectOtherWords() {
        let trie = Trie()
        trie.insert(word: "cat")
        trie.insert(word: "car")
        trie.delete(word: "cat")
        #expect(!trie.contains(word: "cat"))
        #expect(trie.contains(word: "car"))
    }

    @Test
    func deletePrefixWordLeavesLongerWordIntact() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        trie.delete(word: "app")
        #expect(!trie.contains(word: "app"))
        #expect(trie.contains(word: "apple"))
        // prefix path still exists for the longer word
        #expect(trie.search(prefix: "app"))
    }

    @Test
    func deleteLongerWordLeavesPrefixWordIntact() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        trie.delete(word: "apple")
        #expect(!trie.contains(word: "apple"))
        #expect(trie.contains(word: "app"))
    }

    @Test
    func deleteNonExistentWordDoesNotCrash() {
        let trie = Trie()
        trie.insert(word: "cat")
        trie.delete(word: "dog")
        #expect(trie.contains(word: "cat"))
    }

    @Test
    func deleteRemovesWordFromAutocomplete() {
        let trie = Trie()
        trie.insert(word: "app")
        trie.insert(word: "apple")
        trie.delete(word: "app")
        let results = trie.autocomplete("app").sorted()
        #expect(results == ["apple"])
    }
}
