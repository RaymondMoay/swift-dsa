//
//  ImplementTrieTests.swift
//  SwiftDSA
//
//  Created by Ray on 11/5/26.
//

import Testing

@testable import SwiftDSA

struct ImplementTrieTests {

    @Test func canonicalExample() async throws {
        let trie = PrefixTrie()
        trie.insert("apple")
        #expect(trie.search("apple") == true)
        #expect(trie.search("app") == false)
        #expect(trie.startsWith("app") == true)
        trie.insert("app")
        #expect(trie.search("app") == true)
    }

    @Test func searchOnEmptyTrieReturnsFalse() async throws {
        let trie = PrefixTrie()
        #expect(trie.search("anything") == false)
        #expect(trie.startsWith("a") == false)
    }

    @Test func startsWithMatchesWholeWord() async throws {
        let trie = PrefixTrie()
        trie.insert("hello")
        #expect(trie.startsWith("hello") == true)
        #expect(trie.startsWith("hell") == true)
        #expect(trie.startsWith("h") == true)
        #expect(trie.startsWith("helloo") == false)
    }

    @Test func searchDoesNotMatchPrefixOfLongerWord() async throws {
        let trie = PrefixTrie()
        trie.insert("payment")
        // "pay" is a prefix but was never inserted as a full word.
        #expect(trie.search("pay") == false)
        #expect(trie.startsWith("pay") == true)
    }

    @Test func multipleWordsSharingPrefix() async throws {
        let trie = PrefixTrie()
        trie.insert("paynow")
        trie.insert("paylah")
        trie.insert("payment")

        #expect(trie.search("paynow") == true)
        #expect(trie.search("paylah") == true)
        #expect(trie.search("payment") == true)

        #expect(trie.search("pay") == false)
        #expect(trie.startsWith("pay") == true)
        #expect(trie.startsWith("payn") == true)
        #expect(trie.startsWith("payx") == false)
    }

    @Test func reinsertingTheSameWordIsIdempotent() async throws {
        let trie = PrefixTrie()
        trie.insert("grab")
        trie.insert("grab")
        #expect(trie.search("grab") == true)
        #expect(trie.startsWith("gra") == true)
    }

    @Test func disjointBranches() async throws {
        let trie = PrefixTrie()
        trie.insert("apple")
        trie.insert("banana")
        #expect(trie.search("apple") == true)
        #expect(trie.search("banana") == true)
        #expect(trie.startsWith("a") == true)
        #expect(trie.startsWith("b") == true)
        #expect(trie.startsWith("c") == false)
    }

    @Test func singleCharacterWord() async throws {
        let trie = PrefixTrie()
        trie.insert("a")
        #expect(trie.search("a") == true)
        #expect(trie.startsWith("a") == true)
        #expect(trie.search("ab") == false)
    }
}
