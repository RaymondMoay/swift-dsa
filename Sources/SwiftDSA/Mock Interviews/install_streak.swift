// MARK: - Mock Interview: App Install Streak (Monotonic Stack — Stock Span sibling)
//
// You're working on the analytics dashboard for a mobile app. Each day, the
// app's backend records the number of new installs as a single non-negative
// integer. After `n` days you have an array `installs` where `installs[i]`
// is the count for day `i` (0-indexed).
//
// The growth team wants a "streak" badge for every day. The STREAK for day `i`
// is defined as the largest integer `k` such that:
//
//   installs[i - k + 1], installs[i - k + 2], ..., installs[i]
//
// are ALL less than or equal to installs[i]. In other words: how many
// consecutive days ending at day `i` (including day `i` itself) had install
// counts that didn't exceed today's count?
//
// Return an array `streak` of length `n` with `streak[i]` for every day.
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 1
//   installs = [100, 80, 60, 70, 60, 75, 85]
//   streak   = [  1,  1,  1,  2,  1,  4,  6]
//
//   - Day 3 (70): days 3 and 2 have installs ≤ 70 (70 and 60); day 1 has 80
//                 which is greater. Streak = 2.
//   - Day 5 (75): days 5,4,3,2 have installs ≤ 75 (75, 60, 70, 60); day 1 has
//                 80 which is greater. Streak = 4.
//   - Day 6 (85): days 6..1 all ≤ 85; day 0 has 100. Streak = 6.
//
// Example 2
//   installs = [1, 2, 3, 4, 5]
//   streak   = [1, 2, 3, 4, 5]
//   (Strictly increasing — each day's count beats every prior day.)
//
// Example 3
//   installs = [5, 4, 3, 2, 1]
//   streak   = [1, 1, 1, 1, 1]
//   (Strictly decreasing — each day's count is only ≤ itself.)
//
// Example 4
//   installs = [7, 7, 7, 7]
//   streak   = [1, 2, 3, 4]
//   (Equal counts count as ≤, so the streak grows.)
//
// ─────────────────────────────────────────────────────────────────────────────
// Constraints
//   - 1 <= installs.count <= 10^5
//   - 0 <= installs[i] <= 10^9
//   - Your solution must be better than O(n^2). The naïve "for each i, walk
//     left until you hit a larger value" will TLE on the 10^5 stress test.
//
// ─────────────────────────────────────────────────────────────────────────────
// Deliverable
//   func installStreak(_ installs: [Int]) -> [Int]
//
// Walk me through your approach before coding. Pay special attention to:
//   - What does your stack store and what's its monotonic invariant?
//   - Strict `<` vs. non-strict `<=` in your pop condition — which, and why?
//   - When do you record `streak[i]` — before or after pushing onto the stack?

func installStreak(_ installs: [Int]) -> [Int] {
    // Naive solution: iterate, and look back, then count. -> O(n^2) solution.

    // Solution should be at least O(n), since we need to iterate through.
    // So solution must entail some sort of calculation / caching in between...

    // Intuitively, one way to look at it is, what is the largest number before the current? Then my streak is from that
    // day to now.

    var result: [Int] = Array(repeating: 1, count: installs.count)
    var largestDays: [(value: Int, index: Int)] = []

    for i in 0..<installs.count {
        while let nearestLargestDay = largestDays.last, nearestLargestDay.value <= installs[i] {
            largestDays.removeLast() // remove all smaller ones so far
        }
        if let last = largestDays.last {
            result[i] += i - last.index
        }
        largestDays.append((value: installs[i], index: i)) // add it to the stack (its the smallest largest item)
    }

    return result
}



