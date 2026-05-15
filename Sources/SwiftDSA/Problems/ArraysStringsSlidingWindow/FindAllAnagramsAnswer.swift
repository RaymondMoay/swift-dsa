//
//  FindAllAnagramsAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct FindAllAnagramsAnswer {

    /// Fixed-size sliding window over the 26-letter alphabet.
    ///
    /// Maintain frequency arrays for `p` and for the current window of `s`.
    /// Slide the window one position at a time: add the entering character,
    /// remove the exiting character, then compare arrays. The comparison is
    /// O(26) per step which is constant.
    ///
    /// Time:  O(n) — n - m + 1 windows, each O(26) work.
    /// Space: O(1) — fixed 26-slot frequency arrays.
    static func perform(_ s: String, _ p: String) -> [Int] {
        let n = s.count
        let m = p.count
        if m > n { return [] }

        let sBytes = Array(s.utf8)
        let pBytes = Array(p.utf8)
        let a = UInt8(ascii: "a")

        var pCount = Array(repeating: 0, count: 26)
        var wCount = Array(repeating: 0, count: 26)

        for i in 0..<m {
            pCount[Int(pBytes[i] - a)] += 1
            wCount[Int(sBytes[i] - a)] += 1
        }

        var result: [Int] = []
        if pCount == wCount { result.append(0) }

        for i in m..<n {
            wCount[Int(sBytes[i] - a)] += 1
            wCount[Int(sBytes[i - m] - a)] -= 1
            if pCount == wCount {
                result.append(i - m + 1)
            }
        }

        return result
    }
}
