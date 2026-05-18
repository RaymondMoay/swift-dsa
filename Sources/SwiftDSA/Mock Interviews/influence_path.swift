// MARK: - Mock Interview: Maximum Influence Path
//
// At Google, you've been asked to analyze an internal "mentorship tree" used
// by a research org. The tree is a BINARY TREE where each node represents a
// researcher. Every researcher has an integer `influence` score:
//
//   - A POSITIVE score means they amplify a collaboration (e.g., they're a
//     productive contributor).
//   - A NEGATIVE score means they drag it down (e.g., they're a known
//     bottleneck or are on long-term leave).
//   - Zero is possible too.
//
// An "influence path" is any sequence of researchers where consecutive
// researchers are connected by a parent ↔ child edge in the tree. Important
// properties of a path:
//
//   - It must contain AT LEAST ONE node.
//   - It cannot visit the same node twice.
//   - It does NOT have to start at the root, and does NOT have to end at a leaf.
//   - It CAN bend through a node: e.g., go up from the left subtree, through a
//     node, then back down into the right subtree. (But each node still appears
//     at most once.)
//
// The "influence sum" of a path is the sum of `influence` values of every
// researcher on it.
//
// Return the MAXIMUM influence sum achievable over all possible paths in the
// tree. The tree has at least one node (root is non-nil).
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 1
//
//          1
//         / \
//        2   3
//
//   Possible paths and their sums:
//     [2]            -> 2
//     [1]            -> 1
//     [3]            -> 3
//     [2, 1]         -> 3
//     [1, 3]         -> 4
//     [2, 1, 3]      -> 6   ← bends through node 1
//   Answer: 6
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 2
//
//          -10
//          /  \
//         9    20
//             /  \
//            15   7
//
//   Best path: 15 -> 20 -> 7  (sum = 42). The -10 root would only hurt us, so
//   the optimal path skips it entirely.
//   Answer: 42
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 3
//
//          -3
//
//   Only one node. The path must contain at least one node, so we take it.
//   Answer: -3
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 4
//
//          2
//         / \
//       -1   -2
//
//   Paths to consider:
//     [2]            -> 2
//     [-1]           -> -1
//     [-2]           -> -2
//     [-1, 2]        -> 1
//     [2, -2]        -> 0
//     [-1, 2, -2]    -> -1
//   Answer: 2  (just the root alone — both children hurt the sum)
//
// ─────────────────────────────────────────────────────────────────────────────
// Constraints
//   - Number of nodes in the tree is in [1, 3 * 10^4].
//   - -1000 <= node.influence <= 1000
//   - Aim for O(n) time and O(h) space where h is the height of the tree.
//
// ─────────────────────────────────────────────────────────────────────────────
// Tree definition you can assume is already provided:
//
//   final class TreeNode {
//       var influence: Int
//       var left: TreeNode?
//       var right: TreeNode?
//       init(_ influence: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
//           self.influence = influence
//           self.left = left
//           self.right = right
//       }
//   }
//
// ─────────────────────────────────────────────────────────────────────────────
// Deliverable
//   func maxInfluencePath(_ root: TreeNode?) -> Int
//
// ─────────────────────────────────────────────────────────────────────────────
// Before you code, please:
//   1. Walk me through a small example by hand (you can use Example 2).
//   2. Explain what your recursive function returns at each node, and how that
//      differs from the global "best path" you're tracking. This distinction
//      is the heart of the problem — be explicit about it.
//   3. Tell me how you handle negative subtrees.
//
// Then code it up. No need to compile — get the logic right and we'll trace
// through it together.

final class TreeNode {
    var influence: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ influence: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.influence = influence
        self.left = left
        self.right = right
    }
}

func maxInfluencePath(_ root; TreeNode?) -> Int {

    // this is interesting, because i have to start from a single node.
    // But the answer could have multiple single nodes that may not be the root node.

    // If i have 1 node, i can only start traversing from that one node, so during traversal, i will
    // need to record possible combinations, and during exploration, I will also need to consider if 
    // the node i am traversing, as a single node, could actually be the max answer.

    // Intuitively, (maybe naively), i would do this:

    // General strategy: DFS through the nodes to find all possible paths
    // During traversal, i will be building up an array, while maintaing the max sum so far
    // As i move from 1 node to the next, I will need to do 2 computations:
        // 1. is the new node value on its own the max?
        // 2. is the sum the max?
        // Then, whichever is the max, I will set it as my most recently seen MAX

    // Now this will mean that I will definitely traverse all nodes, so O(n) in time complexity.
    // Every traversal, I will do a comparison check with a buildup array. That is O(1) time so thats fine.

    // But i wonder if i can do better...

    // I have a binary tree, correct? Means I have left and right values... i wonder if i should compare values...
    // Wait.. its not a strict binary search tree, meaning even though elft value might be -10 (a decrease), but -10
    // might be connected to 999, a STRONG increase. The best path will still require us to consider that option. We
    // can't eliminate any based off value (we don't know what its connected to!)

    // Ok, i think my initial strategy should be enough, or do you think I'm missing some information i should consider?

    // Ok let me think harder...

    //          1
    //         / \
    //        2   3
    // Assuming the above...

    // Can i do something with a DFS in-order / pre-order traversal here?
    // pre-order, check if the value on its own is the largest, if so, add it to the running sum
    // post-order...
    
    var bestMax = root.influence
    func walk(curr: TreeNode?) -> Int {
        // base case
        guard let curr else { return 0 }

        // recurse

        // pre
        bestMax = max(bestMax, curr.influence) // isit curr itself?

        var circularSum: Int = curr.influence
        var bestDirectionSum: Int = 0

        // recurse
        let leftSum = walk(curr: curr.left)
        let leftChosenSum = leftSum + curr.influence

        bestMax = max(bestMax, leftChosenSum) // isit curr + left?
        circularSum += leftSum
        bestDirectionSum = max(bestDirectionSum, leftChosenSum)

        let rightSum = walk(curr: curr.right)
        let rightChosenSum = rightSum + curr.influence

        bestMax = max(bestMax, rightChosenSum) // isit curr + right?
        circularSum += rightSum
        bestDirectionSum = max(bestDirectionSum, rightChosenSum)

        bestMax = max(bestMax, circularSum) // or issit curr + left + right?

        // post
        // what do we return here?
        return bestDirectionSum
    }

    // So how do we handle this if we were to return paths....

    // Intuitive idea: we should not return bestdirectionsum, we should return the list of numbers that lead to bestdirectionSum. This still allows us to calculate the sum of values, but now we have more information.
    // for circular sum, instead of += a number, we can append the path that lead to the best sum, i.e. best left path and best right path.
    // if circular sum happens to be the best, we will update our bestPath to the circularSum array.
}

func maxInfluencePaths(_ root; TreeNode?) -> [Int] {
    var bestMax = root.influence
    var bestMaxPath = [root]

    func walk(curr: TreeNode?) -> [Int] {
        // base case
        guard let curr else { return [] }

        // recurse

        // pre
        if curr.influence > bestMax { // isit curr itself?
            bestMax = curr.influence
            bestMaxPath = [curr]
        }

        var circularSum: Int = curr.influence

        // recurse
        let leftSumPath = walk(curr: curr.left)
        let leftSum = leftSumPath.reduce(0, +)
        let leftChosenSum = leftSum + curr.influence

        if leftChosenSum > bestMax {
            bestMax = leftChosenSum
            bestMaxPath = [curr] + leftSumPath
        }

        // housekeeping stays, we sitll continue to count circular sum
        circularSum += leftSum

        let rightSumPath = walk(curr: curr.right)
        let rightSum = rightSumPath.reduce(0, +)
        let rightChosenSum = rightSum + curr.influence

        if rightChosenSum > bestMax {
            bestMax = rightChosenSum
            bestMaxPath = [curr] + rightSumPath
        }
        
        circularSum += rightSum

        if circularSum > bestMax {
            bestMax = circularSum
            bestMaxPath = leftSumPath.reversed() + [curr] + rightSumPath()
        }

        // post
        if rightSum > leftSum {
            return [curr] + rightSumPath
        } else {
            return [curr] + leftSumPath
        }
    }

    return bestMaxPath
}