//
//  WordLadderAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct WordLadderAnswer {

    /// Single-source BFS over the implicit "differs by one letter" graph.
    ///
    /// 1. Bail out early if `endWord` is not in the dictionary.
    /// 2. Use a `Set<String>` for O(1) dictionary membership checks, plus a
    ///    second `visited` set to avoid revisiting words.
    /// 3. At each BFS level, for every word in the frontier, mutate each
    ///    position through 'a'..'z' and enqueue any unvisited dictionary
    ///    word. Length increments per BFS level.
    ///
    /// Time:  O(N * L * 26) — N words, L letters, 26 letter swaps each.
    /// Space: O(N * L)      — sets + queue store the words.
    static func perform(beginWord: String, endWord: String, wordList: [String]) -> Int {
        var dictionary = Set(wordList)
        guard dictionary.contains(endWord) else { return 0 }
        if beginWord == endWord { return 1 }

        let alphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
        var queue: [String] = [beginWord]
        dictionary.remove(beginWord)
        var length = 1

        while !queue.isEmpty {
            length += 1
            var nextLevel: [String] = []

            for word in queue {
                var letters = Array(word)
                for i in 0..<letters.count {
                    let original = letters[i]
                    for c in alphabet where c != original {
                        letters[i] = c
                        let candidate = String(letters)
                        if dictionary.contains(candidate) {
                            if candidate == endWord { return length }
                            dictionary.remove(candidate)   // visited
                            nextLevel.append(candidate)
                        }
                    }
                    letters[i] = original
                }
            }

            queue = nextLevel
        }

        return 0
    }
}
