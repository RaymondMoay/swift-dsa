//
//  LongestSubstringWithoutRepeatingAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct LongestSubstringWithoutRepeatingAnswer {

    /// Sliding window with last-seen index map.
    ///
    /// Maintain a window [left, right]. For each character at `right`:
    ///   - if it was seen at index `prev` and `prev >= left`, the window
    ///     contains a duplicate — slide `left` to `prev + 1`.
    ///   - otherwise extend the window and update the best length.
    ///
    /// Time:  O(n) — each index is visited at most twice (right advances n
    ///        times; left only ever advances).
    /// Space: O(min(n, |alphabet|)) — at most one entry per distinct char.
    static func perform(_ s: String) -> Int {
        let chars = Array(s)
        var lastSeen: [Character: Int] = [:]
        var left = 0
        var best = 0

        for right in 0..<chars.count {
            let c = chars[right]
            if let prev = lastSeen[c], prev >= left {
                left = prev + 1
            }
            lastSeen[c] = right
            best = max(best, right - left + 1)
        }

        return best
    }
}
