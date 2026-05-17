// MARK: - Log Ingestion Rate
//
// You're operating a log ingestion service. There are `n` log files sitting in
// object storage, where `files[i]` is the number of log lines in file `i`. You
// have a hard deadline: everything must be ingested in `H` hours.
//
// Your single worker processes log lines at a fixed rate of `K` lines per hour
// and works on ONE file at a time, in any order. Importantly, the worker does
// NOT carry leftover capacity between files within an hour: if it finishes
// file A partway through an hour, the rest of that hour is idle and the
// worker only starts file B at the top of the next hour.
//
// So a file of `f` lines takes ceil(f / K) hours, and the total time is the
// sum of ceil(files[i] / K) across all files.
//
// You're picking the worker's rate `K` (a positive integer lines/hour). Faster
// rates cost more money, so you want the SMALLEST integer `K` such that all
// files are ingested within `H` hours.
//
// Example 1
//   files = [3, 6, 7, 11], H = 8
//   K = 4 -> ceil(3/4)+ceil(6/4)+ceil(7/4)+ceil(11/4) = 1+2+2+3 = 8 ✓
//   K = 3 -> 1+2+3+4 = 10 ✗
//   Answer: 4
//
// Example 2
//   files = [30, 11, 23, 4, 20], H = 5
//   Only K large enough that every file fits in 1 hour works.
//   Answer: 30
//
// Example 3
//   files = [30, 11, 23, 4, 20], H = 6
//   Answer: 23
//
// Constraints
//   - 1 <= files.count <= 10^4
//   - files.count <= H <= 10^9
//   - 1 <= files[i] <= 10^9
//
// Walk me through your approach before coding.

func bestRate(files: [Int], h: Int) -> Int {

    // The goal: is to figure out the best rate, such that we can complete it within `h` hours
    // Has to be just nice, not too little (over exceed time), not too much (too expensive), so we want to finish in `h` hours
    // The best rate = min of K such that it can be completed in `h` hours.

    // k needs to be large enough to clear all tasks within `h` hours, but we need the minimum of the largest K possible.

    // Min max problem -> we neeed to find the minimum of the maximum possible K to complete all files in `h` hours.

    // Rough solution, 2 problems:
    // 1. Utilize a binary search to narrow down to a given value
    // 2. feasible function () -> Bool, so during binary search, do we narrow left or right

    // Solving the first porblem: binary search
    // We need a lo and a hi.
    // Looking at extremes:
    // 1. If h == files.count, meaning we can't have spillovers. K must be the file with the max lines. hi = files.max()
    // 2. If we have only one file... say [5], and we have h = 5. Most cost efficient rate intuitively, would be K = 1. lo = 1.
    // To get the min and max, i probably hvae to naively sort first... `.sort()`

    var lo: Int = 1
    var hi: Int = files.max() // O(N), sort is O(Nlog(N)), so this is sufficient, we don't need the min

    // Test: [3, 6, 7, 11], H = 8
    // 1: lo = 1, hi = 11, mid = 1 + (11 - 1) / 2 = 6, feasible? -> 6 hours... YES
    // 2: lo = 1, hi = 6, mid = 1 + (6-1) / 2 = 3, feasible? -> 10 hours... NO
    // 3: lo = 4, hi = 6, mid = 4 + (6-4) / 2 = 5, feasible? -> 8 hours... YES
    // 4: lo = 4, hi = 5, mid = 4 + (5-4) / 2 = 4, feasible? -> 8 hours... YES
    // 5: lo = 4, hi = 4 <--- break while loop

    // Test: [30, 11, 23, 4, 20], H = 5
    // 1: lo = 1, hi = 30, mid = 1 + (30 - 1) / 2 = 15, feasible? -> 8 hours... NO
    // 2: lo = 16, hi = 30, mid = 16 + (30 - 16) / 2 = 23, feasible? -> 6 hours... NO
    // 3: lo = 23, hi = 30, mid = 23 + (30 - 23) / 2 = 26, feasible? -> 6 hours... NO
    // 4: lo = 26, hi = 30, mid = 26 + (30 - 26) / 2 = 28, feasible? -> 6 hours... NO
    // 5: lo = 28, hi = 30, mid = 28 + (30 - 28) / 2 = 29, feasible? -> 6 hours... NO
    // 6: lo = 29, hi = 30, mid = 29 + (30 - 29) / 2 = 29, feasible? -> 6 hours... NO
    // 6: lo = 30, hi = 30 <--- break while loop
    // NOTE: technically, we can just return early if H == files.count...
    if h == files.count { return hi }

    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if feasible(files: files, h: h, k: mid) {
            hi = mid // if its feasible, can I try reducing the rate until its not?
        } else {
            lo = mid + 1
        }
    }

    return lo
}

// Solving the second problem: feasability function
// I'm going to give a K, is it possible for me to complete the files in K time....
// Walk through each file, process it, count the time taken (ceil), at the end, check if time required is <= H?

// If i can process all files at K rate within H, return true
func feasible(files: [Int], h: Int, k: Int) -> Bool {
    var totalTime: Int = 0
    for file in files {
        let timeTaken = ceil(Double(file) / Double(k))
        totalTime += timeTaken
        if totalTime > h {
            return false // early exit
        }
    }
    return totalTime <= h
}
