// MARK: - Mock Interview: Crash Recovery Time
//
// (Interviewer reads this paragraph out loud. Imagine you have no compiler —
//  pseudocode-correct Swift is fine. Talk me through your reasoning first.)
//
// ─────────────────────────────────────────────────────────────────────────────
//
// You're on the reliability team for a mobile app. Every minute, a background
// telemetry agent records a single integer "stability score" for the app —
// higher is healthier. The agent has been running for `n` minutes, producing
// an array `scores` where `scores[i]` is the score recorded at minute `i`
// (0-indexed). Scores can be any 32-bit integer (positive, zero, or negative).
//
// After a bad minute, the on-call engineer wants to know how long it took for
// things to get STRICTLY better. Concretely, for every minute `i` you must
// return the number of minutes the engineer would have had to wait, starting
// at minute `i`, until the FIRST later minute whose score is strictly higher
// than `scores[i]`.
//
// Return an array `wait` of length `n`, where:
//   - wait[i] = (j - i)  if j is the smallest index > i with scores[j] > scores[i]
//   - wait[i] = 0         if no such j exists (the score at minute i was never
//                         beaten by any later minute in the recorded window).
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 1
//   scores = [3, 1, 4, 1, 5, 9, 2, 6]
//   wait   = [2, 1, 1, 1, 1, 0, 1, 0]
//
//   - i=0 score=3: next strictly-greater is 4 at i=2  -> wait 2
//   - i=1 score=1: next strictly-greater is 4 at i=2  -> wait 1
//   - i=2 score=4: next strictly-greater is 5 at i=4  -> wait 2 ... wait, let
//                  me re-check. Actually scores[3]=1, scores[4]=5 > 4, so the
//                  next index is 4. wait = 4 - 2 = 2.
//                  (Interviewer note: I deliberately mis-stated this so you can
//                   catch it during dry-run. The correct value is 2, not 1.)
//   - i=5 score=9: nothing after is greater -> wait 0
//   - i=7 score=6: end of array          -> wait 0
//
//   Corrected wait = [2, 1, 2, 1, 1, 0, 1, 0]
//
// Example 2
//   scores = [5, 5, 5, 5]
//   wait   = [0, 0, 0, 0]
//   (Strictly greater — equal doesn't count.)
//
// Example 3
//   scores = [7, 6, 5, 4]
//   wait   = [0, 0, 0, 0]
//   (Monotonically decreasing — nothing is ever beaten.)
//
// Example 4
//   scores = [-3, -1, -5, 0]
//   wait   = [1, 2, 1, 0]
//   (Negative scores are fine.)
//
// ─────────────────────────────────────────────────────────────────────────────
// Constraints
//   - 1 <= scores.count <= 10^5
//   - -10^9 <= scores[i] <= 10^9
//   - Your solution should be better than O(n^2). The grader has a test with
//     n = 10^5; quadratic will TLE.
//
// ─────────────────────────────────────────────────────────────────────────────
// Deliverable
//   func recoveryWaits(_ scores: [Int]) -> [Int]
//
// Walk me through your approach (including time/space complexity) BEFORE you
// start coding. When you do code, I won't help unless you get stuck — but
// please think out loud so I can follow your reasoning.

// [3, 1, 4, 1, 5, 9, 2, 6]
// 0: [3]
// 1: [3, 1] <-- smallest always at the end, so we can easily pop it off the stack
// 2: [4], resolve 1, 3
// 3: [4, 1]
// 4: [5], rsolve, 1, 4
// 5: [9], resolve 5
// 6: [9, 2]
// 7: [9], resolve 2

func recoveryWaits(_ scores: [Int]) -> [Int] {
    var waitingStack: [(value: Int, index: Int)] = []
    var result = Array(repeating: 0, count: scores.count)

    for i in 0..<scores.count {
        let currentScore = scores[i]
        while let top = waitingStack.last, top.value < currentScore {
            waitingStack.removeLast()
            result[top.index] = i - top.index
        }
        // Add the current item to the waiting stack
        waitingStack.append((value: currentScore, index: i))
    }

    // For those in the waiting stack but was never resolved, result defaults to 0
    return result
}