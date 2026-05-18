// MARK: - Mock Interview: Reply Chain Hotness
//
// You're building a "trending" feature for a discussion app. A thread is
// modeled as a binary tree of comments — each comment has at most a `left`
// child (the first reply) and a `right` child (the next nested branch).
// (Don't read too much into the left/right semantics; for this problem the
// thread is just a generic binary tree.)
//
// Every comment has a "hotness score" — an integer that can be positive
// (engaging), zero (ignored), or negative (controversial / downvoted).
//
// A "reply chain" is ANY path through the tree such that:
//   - Consecutive nodes in the path are connected by a parent-child edge.
//   - Each node appears at most once.
//   - The path may bend through a node — i.e. it can come up from one
//     subtree, pass through a node, and go back down into the other subtree.
//     (It does NOT have to be a root-to-leaf path, and it does NOT have to
//     include the root.)
//   - A single node by itself counts as a valid chain of length 1.
//
// The "chain score" is the sum of hotness scores of all comments on the path.
//
// Given the root of a thread, return the maximum chain score over all
// possible reply chains in the thread.
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 1
//        1
//       / \
//      2   3
//   Best chain: 2 -> 1 -> 3  (bends through root)
//   Score: 2 + 1 + 3 = 6
//
// Example 2
//        -10
//        /  \
//       9    20
//           /  \
//          15   7
//   Best chain: 15 -> 20 -> 7
//   Score: 15 + 20 + 7 = 42
//   (Bending up into -10 would only hurt; the best chain skips the root.)
//
// Example 3
//        -3
//   Only one node. Best chain is just [-3]. Score = -3.
//   (You MUST include at least one node; you cannot pick the empty chain.)
//
// Example 4
//        2
//       / \
//      -1  -2
//   Best chain: just [2]. Score = 2.
//   (Extending into either child makes the sum smaller.)
//
// ─────────────────────────────────────────────────────────────────────────────
// Constraints
//   - 1 <= number of comments <= 3 * 10^4
//   - -1000 <= hotness <= 1000
//   - The tree is non-empty (root is not nil).
//
// ─────────────────────────────────────────────────────────────────────────────
// Node type (assume this is given to you)
//
//   final class CommentNode {
//       var hotness: Int
//       var left: CommentNode?
//       var right: CommentNode?
//       init(_ hotness: Int, _ left: CommentNode? = nil, _ right: CommentNode? = nil) {
//           self.hotness = hotness
//           self.left = left
//           self.right = right
//       }
//   }
//
// ─────────────────────────────────────────────────────────────────────────────
// Talk me through:
//   - How you'd approach this with recursion. What does each recursive call
//     return, and what does it update?
//   - Be explicit about the distinction between "best chain that ENDS at
//     this node and can be extended upward by my parent" vs. "best chain
//     that PASSES THROUGH this node" — these are NOT the same value, and
//     conflating them is the #1 way this problem goes wrong.
//   - How negatives change the decision when combining children.
//
// Then code it up. No need to handle parsing — just write the function
// that takes a root and returns the answer.

func maxHotnessScore(comment: CommentNode) -> Int {

    var maxValue: Int = comment.hotness // as we walk, we calculate the max values here.

    func walk(curr: CommentNode?) -> Int {
        guard let curr else { return 0 }
        // walk the node, and do some pre,in,post-order based work to track the path...

        // I see 2 paths here... 

        // 1. non bending path, links back to the parent
            // challenge, we need to return the best value to the parent for parent to do its "local" calculation!

        // 2. bending path, does not link back to the parent

        // How about for nested paths? For a given curr and its children, which should they pick, left, or right, to return to the parent?

        // pre order
        var initial = curr.hotness
        maxValue = max(maxValue, initial) // is the root itself the max value?

        let leftGain = max(0, walk(curr.left))
        let initialWithLeft = initial + leftGain
        maxValue = max(maxValue, initialWithLeft) // is the root + left branch the max value?

        let rightGain = max(0, walk(curr.right))
        let initialWithRight = initial + rightGain
        maxValue = max(maxValue, initialWithRight) // is the root + left branch the max value?

        // post order, we do the bend check
        let bendTotal = curr.hotness + leftGain + rightGain
        maxValue = max(maxValue, bendTotal) // is the bend the max value?

        return initial + max(0, max(initialWithRight, initialWithLeft)) // non-zero, maximum of left and right, 0 means we don't take either path.
    }

    _ = walk(curr: comment)

    return maxValue
}