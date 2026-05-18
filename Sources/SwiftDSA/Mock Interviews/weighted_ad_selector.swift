// MARK: - Weighted Ad Selector
//
// You're building an ad-serving service. The system has `n` advertisers, and
// each advertiser `i` has placed a bid with positive integer weight
// `weights[i]`. The bid weight represents how often that advertiser should
// "win" a slot, relative to the others.
//
// Design a class (or struct) that supports the following:
//
//   init(weights: [Int])
//     - Initializes the selector with the given non-empty array of positive
//       integer weights.
//
//   pickIndex() -> Int
//     - Returns an index `i` in the range [0, n-1] at random, such that the
//       probability of returning `i` is proportional to `weights[i]`.
//
// Example:
//   weights = [1, 3]
//     - pickIndex() should return 0 with probability 1/4
//     - pickIndex() should return 1 with probability 3/4
//
//   weights = [1, 3, 2, 6]
//     - total weight = 12
//     - pickIndex() returns 0 with prob 1/12, 1 with 3/12, 2 with 2/12,
//       3 with 6/12
//
// Constraints:
//   - 1 <= weights.count <= 10^4
//   - 1 <= weights[i] <= 10^5
//   - pickIndex() will be called many times — optimize for repeated calls.
//
// You may assume a function `Int.random(in: Range<Int>)` is available to
// generate a uniformly random integer in a half-open range.

class AdvertisementPicker {

    let boundaries: [Int]

    // init gets called once
    init(weights: [Int]) {
        self.weights = weights
        // cache probabilities upfront
        // total = 12

        // if random number falls between:
        // [0, 1] -> return index 0
        // (1-3] -> return index 1
        // (3-6] -> return index 2
        // (6-12] -> return index 3

        // i'm thinking about how a hashmap fundamentally works...
        // when we hash a key and modulo it by capacity, it gives us the approximate bucket
        // can we be inspired by this... or not?

        // or can we do a range lookup?

        // naively, i can loop through the numbers and store them as keys in hashmap...

        // [0: 0, 1: 1, 2: 1, 3: 1, 4: 1 ... ], but this will be very bad space complexity, and time is O(N)

        // Good news is lookup is O(1), which is pickIndex. But i'm thinking if we can make it even better space wise...

        // Could we do something binary-search like?, so we build it at O(log(n)) times (so is storage... i think!

        // Given a randomInt, say 8, which bucket does it belong to?

        // from [1, 3, 2, 6], top boundaries are -> [1, 4, 6, 12]. Where for index 2, range is (1, 4].

        // binary search range in... [1, 4, 6, 12], return the bucket it belongs in. 

        // lo = 1, hi = 12, needle = 8

        var runningSum: Int = 0
        for i in 0..<weights.count {
            runningSum += weights[i]
            boundaries.append(runningSum) // [1,4,6,12]
        }
    }

    // pick index gets called many times, O(log(n)) where n = weights
    func pickIndex() -> Int {
        var lo = 0
        var hi = weights.count - 1 // last item is largest in accumulating array
        var randomInt = Int.random(in: 1...12)
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if randomInt >= boundaries[mid] {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return lo // lo is now the index that matches the right bucket...
    }

    /// Run through the logic: bucket: [1,4,6,12]

    /// randInt = 8
    /// 0: lo = 0, hi = 3, mid = 0 + 3 / 2 = 1. boundaries[1] = 4, randInt > 4
    /// 1: lo = 2, hi = 3, mid = 2 + 1 / 2 = 2. boundaries[2] = 6, randInt > 6
    /// 2: lo = 3, hi = 3 <-- break
    /// index is 3. 3 corresponds to last bucket, which is ad with weight 6. Correct.

    /// randInt = 0
    /// 0: lo = 0, hi = 3, mid = 0 + 3 / 2 = 1. boundaries[1] = 4, randInt < 4
    /// 1: lo = 0, hi = 1, mid = 0 + 1 / 2 = 0. boundaries[0] = 1, randInt < 1
    /// 2: lo = 0, hi = 0 <-- break
    /// index is 0. 0 corresponds to first bucket, which is ad with weight 1. Correct.

    /// randInt = 5
    /// 0: lo = 0, hi = 3, mid = 0 + 3 / 2 = 1. boundaries[1] = 4, randInt > 4
    /// 1: lo = 2, hi = 3, mid = 2 + 1 / 2 = 2. boundaries[2] = 6, randInt < 6
    /// 2: lo = 2, hi = 2 <-- break
    /// index is 2. 2 corresponds to third bucket, which is ad with weight 2. Correct.

    /// randInt = 6
    /// 0: lo = 0, hi = 3, mid = 0 + 3 / 2 = 1. boundaries[1] = 4, randInt > 4
    /// 1: lo = 2, hi = 3, mid = 2 + 1 / 2 = 2. boundaries[2] = 6, randInt == 6
    /// 2: lo = 3, hi = 3 <-- break
    /// index is 3. 3 corresponds to forth bucket, which is ad with weight 12. Correct.
}