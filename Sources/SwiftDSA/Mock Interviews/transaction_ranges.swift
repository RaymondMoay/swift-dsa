// MARK: - Mock Interview: Transaction Ranges
//
// You're building a tool for an accounting team. Each day, the team records a
// single integer representing the net change in a customer's balance for that
// day. A positive number means money came in; a negative number means money
// went out; zero means no activity.
//
// The team has a list of these daily net-change values, in order, as an array
// of integers `transactions`. They also have a target net change `k`.
//
// Your job: write a function that returns the total number of contiguous
// day-ranges (subarrays) whose net change sums exactly to `k`.
//
// A "day-range" is any contiguous slice of one or more days. Two ranges are
// considered different if their start day or end day differs — even if they
// contain the same values.
//
// Example 1:
//   transactions = [1, 1, 1]
//   k = 2
//   -> 2
//   (Days 0..1 sum to 2; days 1..2 sum to 2.)
//
// Example 2:
//   transactions = [3, 4, 7, 2, -3, 1, 4, 2]
//   k = 7
//   -> 4
//   (The ranges that sum to 7 are: [3,4], [7], [7,2,-3,1], [1,4,2].)
//
// Example 3:
//   transactions = [0, 0, 0, 0]
//   k = 0
//   -> 10
//   (Every non-empty contiguous range sums to 0.)
//
// Constraints:
//   - 1 <= transactions.count <= 20_000
//   - -1000 <= transactions[i] <= 1000
//   - -10^7 <= k <= 10^7
//   - Values may be negative, positive, or zero.
//
// Start by writing your function signature, then talk through your approach
// before coding. Think about time and space complexity as you go.

func dayRangeNumber(transactions: [Int], k: Int) -> Int {

    // The naive strategy would be to: for every number, loop through its subsequent numbers and sum, then compare and keep a count
    // of the number of contiguous array whose sum = k. However, this is O(n^2), so lets do a little better than that.

    // I'm just going through diff strategies in my head for arrays... The goal is to do something at every iteration, rather than a loop at every iteration.

    // My intuition is to use a sliding window strategy when I saw subarrays, but given that it is negative,
    // sliding windows does not work.

    // Instead, I'll use a prefix sum + hashmap strategy to look up previously accumulated sums.
    // The logic works like this, at least in my head:
    // Imagine I am a mountain climber. Every checkpoint I reach I calculate how far I have climbed (my altitude).
    // If i ever wanted to know, at a given checkpoint, how much I have hiked, I just minus the altitude of the current checkpoint to any of the previous marked ones
    // Therefore, prefixSum(j) - prefixSum(i) = k, where j > i. Therefore, prefixSum(i) = prefixSum(j) - k
    // So as long as I check my log book, and I have seen prefixSum(j) - k before (in other words, prefixSum(i)), then I have "satisfied" the equation above, meaning 
    // thats the number of times I have seen the sum k.

    // Translating to this problem , its similar. Altitude == Sum, and every days value is a "hike" up and down.

    // Time complexity: O(n), because I am doing an operation at every iteration.

    var runningSum: Int = 0
    var count: Int = 0
    var lookup: [Int: Int] = [0: 1]

    for t in transactions {
        runningSum += t
        // have i seen t - k before?
        if let prev = lookup[runningSum - k] {
            count += prev // yes, add to count
        }
        lookup[runningSum, default: 0] += 1 // store our "altitude" / sum
    }
    return count
}