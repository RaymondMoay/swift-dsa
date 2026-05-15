//
//  MinimumWindowSubstringAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct MinimumWindowSubstringAnswer {

    /// Variable-size sliding window with "formed" counter.
    ///
    /// `need[c]`  — how many of character `c` are required by `t`.
    /// `have[c]`  — how many of `c` currently sit inside the window.
    /// `required` — number of distinct characters in `t`.
    /// `formed`   — number of distinct characters whose `have[c] >= need[c]`.
    ///
    /// Expand `right` until the window is valid (`formed == required`),
    /// then contract `left` as far as possible while still valid, recording
    /// the smallest valid window seen.
    ///
    /// Time:  O(m + n) — each index visited at most twice (once by right,
    ///        once by left).
    /// Space: O(|alphabet|) — bounded by distinct chars in t.
    static func perform(_ s: String, _ t: String) -> String {
        if s.isEmpty || t.isEmpty || t.count > s.count { return "" }

        let chars = Array(s)
        var need: [Character: Int] = [:]
        for c in t { need[c, default: 0] += 1 }

        let required = need.count
        var have: [Character: Int] = [:]
        var formed = 0

        var left = 0
        var bestStart = 0
        var bestLen = Int.max

        for right in 0..<chars.count {
            let c = chars[right]
            if need[c] != nil {
                have[c, default: 0] += 1
                if have[c] == need[c] {
                    formed += 1
                }
            }

            while formed == required {
                let windowLen = right - left + 1
                if windowLen < bestLen {
                    bestLen = windowLen
                    bestStart = left
                }

                let leftChar = chars[left]
                if let needCount = need[leftChar] {
                    have[leftChar]! -= 1
                    if have[leftChar]! < needCount {
                        formed -= 1
                    }
                }
                left += 1
            }
        }

        if bestLen == Int.max { return "" }
        return String(chars[bestStart..<(bestStart + bestLen)])
    }
}
