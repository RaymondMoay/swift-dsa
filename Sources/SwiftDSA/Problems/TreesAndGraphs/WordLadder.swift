//
//  WordLadder.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 127 — Word Ladder
//
//  Given two words `beginWord` and `endWord` and a dictionary `wordList`,
//  return the length of the shortest transformation sequence from
//  `beginWord` to `endWord` such that:
//    1. Only one letter can be changed at a time.
//    2. Each transformed word must exist in the word list.
//
//  The length counts both endpoints (so begin -> end via 3 hops is length 5).
//
//  Return 0 if no such sequence exists. `endWord` must be in `wordList`;
//  otherwise return 0.
//
//  Example:
//    begin = "hit", end = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
//      -> 5   ("hit" -> "hot" -> "dot" -> "dog" -> "cog")
//
//    begin = "hit", end = "cog", wordList = ["hot","dot","dog","lot","log"]
//      -> 0   (endWord not in list)
//
//  Constraints:
//    1 <= beginWord.count <= 10
//    All words have the same length, lowercase a-z, all distinct.
//    1 <= wordList.count <= 5000
//
//  Hints:
//    - Treat each word as a graph node; an edge connects two words that
//      differ in exactly one position. The graph is implicit — you don't
//      build adjacency lists, you generate neighbours on the fly.
//    - BFS from `beginWord` for shortest path. Track the level (path length).
//    - To enumerate neighbours of a word in O(L * 26) instead of O(N * L),
//      try replacing each position with every letter 'a'..'z' and check
//      membership in a `Set<String>` built from `wordList`.
//    - Bidirectional BFS roughly halves the explored space — useful stretch.
//
//  Domain framing (from study guide):
//    Models state-transition search — e.g. enumerating valid next states a
//    payment can move into and finding the shortest sequence from "Initiated"
//    to "Settled" through legal intermediate statuses.
//
//  Target: O(N * L * 26) time, O(N * L) space, where N = wordList count and
//          L = word length.

struct WordLadder {

    static func perform(beginWord: String, endWord: String, wordList: [String]) -> Int {

        // TODO: BFS over implicit graph. Generate one-letter-difference
        // neighbours per node and stop when you reach `endWord`.
        return 0
    }
}
