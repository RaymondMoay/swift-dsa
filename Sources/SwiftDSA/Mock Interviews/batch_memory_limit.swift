// MARK: - Mock Interview: Batch Memory Limit
//
// You're working on a data ingestion pipeline. Your service receives a
// sequence of `N` log records, in the order they arrived. Each record has a
// known size in bytes:
//
//     records = [s_0, s_1, s_2, ..., s_{N-1}]   // each s_i > 0
//
// Downstream, these records must be processed in exactly `D` consecutive
// batches. Two hard constraints:
//
//   1. The original arrival order MUST be preserved. A batch is always a
//      contiguous slice of the input (no reordering, no skipping).
//   2. Every batch must fit inside a fixed per-batch memory budget `M`
//      (in bytes). That is, the sum of sizes in any single batch is <= M.
//
// Your job: given `records` and `D`, return the SMALLEST memory budget `M`
// such that it is possible to partition the records into exactly `D`
// non-empty, contiguous batches where every batch's total size is <= M.
//
// Example 1:
//   records = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//   D = 5
//   Answer: 15
//   One valid split with M = 15:
//     [1,2,3,4,5] (sum 15)
//     [6,7]       (sum 13)
//     [8]         (sum 8)
//     [9]         (sum 9)
//     [10]        (sum 10)
//
// Example 2:
//   records = [3, 2, 2, 4, 1, 4]
//   D = 3
//   Answer: 6
//   Valid split: [3,2] [2,4] [1,4]
//
// Example 3:
//   records = [1, 2, 3, 1, 1]
//   D = 4
//   Answer: 3
//
// Assumptions:
//   - 1 <= D <= N <= 5 * 10^4
//   - 1 <= s_i <= 500
//
// Design the function signature yourself.

// goal: find the smallest memory such that we can split records into batchSize to process
func smallestMemoryBudget(records: [Int], batchSize: Int) -> Int {

    // brute force: i have to iterate from min M to max M, then for each M, iterate and see if its possible to fit into it.

    // if minM is 3, but maxM is like 999 (an array of 333 x 3s), then i will have to do O(M*n).

    // find the MINIMUM memory budget that can cater to all records.

    // looks like a min max problem. We are trying to minimize the maximum memory needed to process all records in batchSize.

    // think about a binary search for a value

    // 2 problems:

    // 1. binary search problem ->
    // Whats the lo and hi?
    // Extreme 1: D == N. Best case, is one item per batch, then max memory = records.max()
    // Extreme 2: D == 1. records.reduce(0, +), the sum of the whole array.
    // lo = 1, hi = records.reduce(0, +), the sum of everything

    var lo = records.max()! // 1 is impossible, we need to have enough memory to compelte the largest single record.
    var hi = records.reduce(0, +)

    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if feasible(records: records, batchSize: batchSize, memory: mid) {
            hi = mid
        } else {
            lo = mid + 1
        }
    }

    return lo
}

// 2. optimisation function problem -> 

/// Given memory per bath, can I complete it in batchSize?
// [1, 2, 3, 1, 1], batchSize = 3, memory: 4
func feasible(records: [Int], batchSize: Int, memory: Int) -> Bool {
    var requiredBatchSize: Int = records.first!
    var currentBatchMemory: Int = 1
    for i in 1..<records.count {
        if currentBatchMemory + records[i] > memory {
            currentBatchMemory = 0
            requiredBatchSize += 1
        }
        currentBatchMemory += records[i]
        // for each record, we add up to memory, then move to next batch
    }

    return requiredBatchSize <= batchSize
}

// iterate and test...
// [1, 2, 3, 1, 1], batchSize = 3, memory: 4
// 0: 1 -> requiredBatchSize = 0, currentBatchMemory = 0, 0 + 1 > 4 ? false. -> currentBatchMemory += 1 = 1
// 1: 2 -> requiredBatchSize = 1, currentBatchMemory = 1, 1 + 2 > 4 ? false. -> currentBatchMemory += 2 = 3
// 2: 3 -> requiredBatchSize = 1, currentBatchMemory = 3, 3 + 3 > 4 ? true. -> requiredBatchSize = 2, currentBatchMemory = 3
// 3: 1 -> requiredBatchSize = 2, currentBatchMemory = 3, 3 + 1 > 4 ? false. -> currentBatchMemory += 1 = 4
// 4: 1 -> requiredBatchSize = 2, currentBatchMemory = 4, 4 + 1 > 4 ? true. -> requiredBatchSize = 3, currentBatchMemory = 1
// Net required: 3, batchSize 4, return TRUE. Possible.

// Final time complexity: O(nlog(M))