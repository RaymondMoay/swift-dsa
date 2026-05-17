// MARK: - Map Tile Shard Size
//
// You operate a map rendering pipeline. There are `n` batches of map tiles
// waiting to be rendered, where `tiles[i]` is the number of tiles in batch i.
//
// To render a batch, you split it into shards of size at most `S` (the shard
// size you're picking). Each shard is then dispatched to a worker, which
// renders the shard in exactly 1 unit of time, regardless of how many tiles
// (1 to S) the shard actually contains. Shards from different batches CANNOT
// be combined.
//
// So a batch of `b` tiles produces ceil(b / S) shards and therefore takes
// ceil(b / S) time units. The TOTAL processing time across all batches is the
// sum of ceil(tiles[i] / S).
//
// You have a deadline of `T` total time units. Find the SMALLEST integer
// shard size `S` such that the total processing time is at most `T`.
//
// (Why smallest? Smaller S = more shards = more parallelism on the cluster
// = more memory/IO efficient. You want the smallest S that still meets the
// deadline.)
//
// Example 1
//   tiles = [1, 2, 5, 9], T = 6
//   S = 5 -> 1 + 1 + 1 + 2 = 5 ≤ 6 ✓
//   S = 4 -> 1 + 1 + 2 + 3 = 7 > 6 ✗
//   Answer: 5
//
// Example 2
//   tiles = [44, 22, 33, 11, 1], T = 5
//   S must be large enough that every batch fits in one shard.
//   Answer: 44
//
// Example 3
//   tiles = [21212, 10101, 12121], T = 1000000
//   T is enormous; even S = 1 fits easily.
//   Answer: 1
//
// Constraints
//   - 1 <= tiles.count <= 5 * 10^4
//   - tiles.count <= T <= 10^6
//   - 1 <= tiles[i] <= 10^6
//
// Walk me through your approach before coding.

func bestShards(tiles: [Int], t: Int) -> Int {

    // Goal: minimize S such that we can still process all tiles within t
    // Since this is a minimization logic, I can think of a binary search to find a value in log(tiles[i]).

    // 2 problems

    // First, binary search's low and high value
    // Second, binary search's condition / feasibility function -> Bool

    // First problem, hi and low
    // What are the extreme values?
    // When T == tiles.count, therefore we have to solve all tile in 1 unit of time, no spillovers. Therefore, hi = tiles.max()
    // For lo, we can just use 1, becvause 1 is the theoretical minimum for S and we are trying to find the minimum S!

    var lo = 1
    var hi = tiles.max()!

    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if feasible(tiles: tiles, t: int, proposedS: mid) {
            hi = mid // minimize shard as much as we can...
        } else {
            lo = mid + 1
        }
    }

    return lo
}

// Second problem, feasibility function
// loop through each tile, for tile, do ceil(Double(tile) / Double(S)) to get the time taken to complete one tile.
// Sum those at every iteraton, and return totalTimeTaken <= T. If total time taken is less than time limit, it can be done!
// Fn logic: Given S, can I comeplete the tiles within time T?

func feasibility(tiles: [Int], t: Int, proposedS: Int) -> Bool {
    var timeTaken: Int = 0
    for tile in tiles {
        timeTaken += (tile + proposedS - 1) / proposedS // how you do a ceiling...
        if timeTaken > t {
            return false
        }
    }
    return true
}