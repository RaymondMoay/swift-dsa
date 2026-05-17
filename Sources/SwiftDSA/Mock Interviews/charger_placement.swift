// MARK: - EV Charger Placement
//
// You're rolling out EV chargers along a single straight highway. You're given
// `n` candidate positions on the highway as integer coordinates in the array
// `positions` (positions are distinct but NOT guaranteed sorted on input).
//
// You have `m` chargers to install. Each chosen position holds exactly one
// charger; you may NOT install two chargers at the same position. Customer
// research says clustered chargers are useless — riders want them spread out.
//
// Choose `m` of the `n` candidate positions so that the MINIMUM pairwise
// distance between any two installed chargers is as LARGE as possible.
// Return that maximum-possible minimum distance.
//
// Example 1
//   positions = [1, 2, 4, 8, 9], m = 3
//   Install at {1, 4, 8} -> pairwise distances {3, 4, 7}, min = 3
//   Install at {1, 4, 9} -> distances {3, 5, 8}, min = 3
//   Install at {2, 4, 9} -> distances {2, 5, 7}, min = 2
//   No placement of 3 chargers achieves min distance > 3.
//   Answer: 3
//
// Example 2
//   positions = [5, 4, 3, 2, 1, 1000000000], m = 2
//   Best is the extremes: {1, 1000000000} -> min distance 999999999.
//   Answer: 999999999
//
// Example 3
//   positions = [1, 2, 3, 4, 7], m = 3
//   Install at {1, 4, 7} -> min distance 3.
//   Answer: 3
//
// Constraints
//   - 2 <= m <= n <= 10^5
//   - 1 <= positions[i] <= 10^9
//   - All positions are distinct
//
// Walk me through your approach before coding.

func maxPossibleMinDistance(n: [Int], m: Int) -> Int {
    // Maximizing the minimum distance between the distance between two points.
    // The goal is to have the largest coverage possible wiht our limited constraint, which is m
    // How can we cover the most distance, without being too far apart too.
    // Binary search for a value.

    // What are the extremes?
    // m == n -> every point has a charger -> 1
    // m == 2 -> to maximize the coverage, put one at max, and one at min. -> we get the LARGEST minimum distance -> n.max() - n.min()

    var sortedN = n.sorted() // O(nlog(n))
    var lo: Int = 1 // set to 1! at m == n, min is 1!!
    var hi: Int = sortedN[sortedN.count - 1]

    while lo < hi {
        let mid = lo + (hi - lo) / 2 // int in Swift floors naturally
        if feasible(sortedN: sortedN, m: m, minDist: mid) {
            lo = mid + 1
        } else {
            hi = mid
        }
    }

    return lo - 1
}

// Run through:
// 1: lo = 1, hi = 7, mid = 4, feasible? NO
// 2: lo = 1, hi = 4, mid = 2, feasible? YES
// 3: lo = 3, hi = 4, mid = 3 + (4 - 3) / 2 = 3, feasible? YES
// 4: lo = 4, hi = 4, while loop breaks, therefore we found the minimum
// return lo - 1

// [1, 2, 3, 4, 7], m = 3, minDist: 3
// [1,4,999], m = 2, minDist: 5 -> false (we cannot satisfy, minDist is 999)
func feasible(sortedN: [Int], m: Int, minDist: Int) -> Bool {
    // 1. Since its sorted, we want to assign as early as possible (max pairwise distance)
    var currentLowest = sortedN[0]
    var fitted: Int = 1

    for i in 1..<sortedN.count {
        let dist = sortedN[i] - currentLowest
        if dist >= minDist {
            currentLowest = sortedN[i]
            fitted += 1
        }
    }
    // if chargers needed to satisfy minDist is greater than what we have, its not feasible...
    return fitted >= m 
}