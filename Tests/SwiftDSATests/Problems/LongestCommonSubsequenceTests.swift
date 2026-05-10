//
//  LongestCommonSubsequenceTests.swift
//  SwiftDSA
//
//  Created by Ray on 9/5/26.
//

import Testing

@testable import SwiftDSA

struct LongestCommonSubsequenceTests {

    @Test func topDown() async throws {
        #expect(LongestCommonSubsequence.performTopDown("abcde", "ace") == 3)
        #expect(LongestCommonSubsequence.performTopDown("abc", "abc") == 3)
        #expect(LongestCommonSubsequence.performTopDown("abc", "def") == 0)
        #expect(LongestCommonSubsequence.performTopDown("", "abc") == 0)
        #expect(LongestCommonSubsequence.performTopDown("abc", "") == 0)
        #expect(LongestCommonSubsequence.performTopDown("", "") == 0)
        #expect(LongestCommonSubsequence.performTopDown("bsbininm", "jmjkbkjkv") == 1)
        #expect(LongestCommonSubsequence.performTopDown("ezupkr", "ubmrapg") == 2)   // "ur"
        #expect(LongestCommonSubsequence.performTopDown("oxcpqrsvwf", "shmtulqrypy") == 2) // "qr"
    }

    @Test func bottomUp() async throws {
        #expect(LongestCommonSubsequence.performBottomUp("abcde", "ace") == 3)
        #expect(LongestCommonSubsequence.performBottomUp("abc", "abc") == 3)
        #expect(LongestCommonSubsequence.performBottomUp("abc", "def") == 0)
        #expect(LongestCommonSubsequence.performBottomUp("", "abc") == 0)
        #expect(LongestCommonSubsequence.performBottomUp("abc", "") == 0)
        #expect(LongestCommonSubsequence.performBottomUp("", "") == 0)
        #expect(LongestCommonSubsequence.performBottomUp("bsbininm", "jmjkbkjkv") == 1)
        #expect(LongestCommonSubsequence.performBottomUp("ezupkr", "ubmrapg") == 2)
        #expect(LongestCommonSubsequence.performBottomUp("oxcpqrsvwf", "shmtulqrypy") == 2)
    }
}
