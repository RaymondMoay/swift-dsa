// MARK: - Build Farm Scheduling
//
// You're an SRE managing a build farm. There are `n` build jobs sitting in a
// queue, each with a known processing duration (a positive integer number of
// seconds). You have `k` identical machines available to run them in parallel.
//
// Constraints on how jobs are assigned:
//   - The jobs in the queue MUST be processed in their current order — you are
//     not allowed to reorder them.
//   - You assign each machine a CONTIGUOUS block of jobs from the queue.
//     (One machine takes some prefix-suffix range, the next takes the range
//     immediately after, and so on.)
//   - Every job must be assigned to exactly one machine. A machine may end up
//     with zero jobs only if k > n.
//   - A machine's finish time is the sum of the durations of the jobs it owns.
//     All machines start at time 0 and run in parallel.
//
// The build is considered finished when the SLOWEST machine finishes (the
// "makespan"). Your goal is to split the queue into k contiguous blocks so
// that the makespan is as small as possible. Return that minimum makespan.
//
// Example 1
//   jobs = [7, 2, 5, 10, 8], k = 2 [10, 32]
//   Some possible splits:
//     [7, 2, 5] | [10, 8]      -> max(14, 18) = 18
//     [7, 2, 5, 10] | [8]      -> max(24, 8) = 24
//     [7] | [2, 5, 10, 8]      -> max(7, 25) = 25
//   Answer: 18
//
// Example 2
//   jobs = [1, 2, 3, 4, 5], k = 2
//   Best split: [1, 2, 3] | [4, 5] -> max(6, 9) = 9
//   Answer: 9
//
// Example 3
//   jobs = [1, 4, 4], k = 3
//   Each machine takes exactly one job -> max(1, 4, 4) = 4
//   Answer: 4
//
// Constraints
//   - 1 <= k <= n <= 1000
//   - 1 <= jobs[i] <= 10^6
//
// Walk me through your approach before coding. Code in Swift. No tests
// required, just rough correctness.

func minimumMakespan(jobs: [Int], k: Int) -> Int {
    var lo = jobs.max()
    var hi: Int = 0
    for j in jobs {
        hi += j
    }
    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if feasible(jobs: jobs, m: mid, k: k) {
            hi = mid
        } else {
            lo = mid + 1
        }
    }
    return lo
}

// jobs: [1, 4, 4, 2], k = 1, m = 8, m range = (4, 11)
func feasible(jobs: [Int], m: Int, k: Int) -> Bool {
    var runningSum: Int = 0
    var machineCount: Int = 1
    for j in jobs {
        runningSum += j
        if runningSum > m {
            runningSum = j
            machineCount += 1
        }
        if machineCount > k {
            return false
        }
    }
    return true
}