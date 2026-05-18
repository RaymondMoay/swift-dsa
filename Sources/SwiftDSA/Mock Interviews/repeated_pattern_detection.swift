// MARK: - Mock Interview: Repeated Pattern Detection
//
// (Interviewer reads this paragraph out loud. Imagine you have no compiler —
//  pseudocode-correct Swift is fine. Talk me through your reasoning first,
//  then code it up.)
//
// ─────────────────────────────────────────────────────────────────────────────
//
// You're working on an anomaly-detection system for a mobile device. The
// device's diagnostic firmware emits a hierarchical snapshot every second:
// each snapshot is shaped like a tree, where every node carries an integer
// "sensor reading", and a node can have a left child, a right child, both,
// or neither.
//
// Your team has noticed that when the device starts to misbehave, the same
// sub-pattern of readings tends to appear in multiple places within a single
// snapshot. You've been asked to write a function that, given one snapshot,
// finds every sub-pattern that appears MORE THAN ONCE inside it.
//
// Two sub-patterns are considered the same if and only if:
//   1. They have the exact same shape (same left/right structure), AND
//   2. The integer reading at every corresponding position is identical.
//
// Return a list containing the root of ONE representative sub-pattern for
// each group of duplicates. The order of the returned list does not matter.
// If no sub-pattern repeats, return an empty list.
//
// ─────────────────────────────────────────────────────────────────────────────
//
// You can assume the following node type exists. You do NOT need to redefine
// it — just use it.
//
//   final class Node {
//       var value: Int
//       var left: Node?
//       var right: Node?
//       init(_ value: Int, _ left: Node? = nil, _ right: Node? = nil) {
//           self.value = value
//           self.left = left
//           self.right = right
//       }
//   }
//
// ─────────────────────────────────────────────────────────────────────────────
// Example 1
//
//   Snapshot:
//                1
//               / \
//              2   3
//             /   / \
//            4   2   4
//               /
//              4
//
//   The sub-pattern rooted at the leaf `4` (no children) appears in three
//   places: as the left child of the leftmost `2`, as the left child of the
//   `2` under the right `3`, and (no — wait, let me re-read my own example)
//   ... it appears at positions (left of leftmost 2) and (the standalone 4
//   child of the inner 2). That's two occurrences of the single-node `4`.
//
//   The sub-pattern rooted at "2 with a left-child 4" also appears twice
//   (once on the left side of the root, once under the right `3`).
//
//   So the answer is the list of two representative roots:
//     - any one of the `4`-leaves
//     - any one of the `2 -> 4` subtrees
//
// Example 2
//
//   Snapshot:
//                1
//               / \
//              2   2
//
//   The single-node sub-pattern `2` appears twice. Return one of them.
//   The whole tree appears only once. Return [<a 2-node>].
//
// Example 3
//
//   Snapshot:
//                1
//               /
//              2
//             /
//            3
//
//   Every sub-pattern is unique. Return [].
//
// ─────────────────────────────────────────────────────────────────────────────
// Constraints
//
//   - The snapshot has between 1 and 5,000 nodes.
//   - Each reading fits in a 32-bit signed integer.
//   - Aim for a solution that is better than O(n^2) overall. A naïve
//     "compare every pair of subtrees" approach will time out at n = 5000.
//
// ─────────────────────────────────────────────────────────────────────────────
// Deliverable
//
//   func findRepeatedPatterns(_ root: Node?) -> [Node]
//
// Walk me through your approach (including time/space complexity) BEFORE you
// start coding. While you code, please think out loud — I won't interrupt
// unless you get stuck or head somewhere I want to probe.

func findRepeatedPatterns(_ root: Node?) -> [Node] {
    
    // Cool! Since the shape matters, I will have to use DFS instead of BFS, simply because DFS preserves shape. the call stack preserves shape.

    // Intuitively, I think i will probably start DFS-ing from the root node, and use some sort of in-order / pre-order / post-order traversal
    // to "collect" some values. I will start by roughly sketching the DFS and thinking about which recursion order I should be processing, if thats ok?

    // The idea is that every node can be a pattern.

//                1
//               / \
//              2   3
//             /   / \
//            4   2   4
//               /
//              4

    var lookup: [String: (val: Int, node: Node)] = [:]

    func walk(curr: Node?) -> String {
        // base
        guard let curr else { return "#" }

        // recurse
        let leftVal = walk(curr.left)
        let rightVal = walk(curr.right)
        let identifier = "\(curr.value),\(leftVal),\(rightVal)"

        if let seen = lookup[identifier]?.val {
            lookup[identifier] = (val: seen + 1, node: curr)
        } else {
            lookup[identifier] = (val: 1, node: curr)
        }

        // LESSON: Complete the tree in post-order then compare. DO NOT USE INTERMEDIATE VALUES WHEN COMPARING SHAPES.
        // sometimes its useful though, i.e. when we are traversing graphs and just want the sum of certain paths, but for
        // "shape" types, we must always consider the FULL tree...

        // post
        return identifier
    }

    _ = walk(curr: root)

    var result: [Node] = []
    for seen in lookup.values {
        guard seen.val > 1 else { continue }
        result.append(seen.node)
    }

    return result
}