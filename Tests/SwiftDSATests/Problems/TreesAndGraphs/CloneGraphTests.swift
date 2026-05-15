//
//  CloneGraphTests.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

import Testing

@testable import SwiftDSA

struct CloneGraphTests {

    /// Walks the cloned graph from `clone` and the original graph from
    /// `original` simultaneously, asserting:
    ///   - structure (same value, same neighbour layout)
    ///   - independence (no shared `GraphNode` references)
    private func verifyDeepClone(
        original: GraphNode?,
        clone: GraphNode?
    ) -> Bool {
        switch (original, clone) {
        case (nil, nil): return true
        case (nil, _), (_, nil): return false
        case let (o?, c?):
            var seen: [ObjectIdentifier: GraphNode] = [:]

            func walk(_ o: GraphNode, _ c: GraphNode) -> Bool {
                if o === c { return false } // shared reference => not a clone
                if o.value != c.value { return false }
                if o.neighbours.count != c.neighbours.count { return false }

                let key = ObjectIdentifier(o)
                if let prevClone = seen[key] {
                    return prevClone === c
                }
                seen[key] = c

                for (oNeighbour, cNeighbour) in zip(o.neighbours, c.neighbours) {
                    if !walk(oNeighbour, cNeighbour) { return false }
                }
                return true
            }

            return walk(o, c)
        default:
            return false
        }
    }

    @Test func nilInputReturnsNil() async throws {
        #expect(CloneGraph.perform(nil) == nil)
    }

    @Test func singleIsolatedNode() async throws {
        let original = GraphNode(1)
        let cloned = CloneGraph.perform(original)
        #expect(verifyDeepClone(original: original, clone: cloned))
    }

    @Test func selfLoop() async throws {
        let original = GraphNode(1)
        original.neighbours = [original]

        let cloned = CloneGraph.perform(original)
        #expect(verifyDeepClone(original: original, clone: cloned))
        #expect(cloned?.neighbours.first === cloned) // loop preserved
    }

    @Test func twoNodeCycle() async throws {
        // 1 <-> 2
        let one = GraphNode(1)
        let two = GraphNode(2)
        one.neighbours = [two]
        two.neighbours = [one]

        let cloned = CloneGraph.perform(one)
        #expect(verifyDeepClone(original: one, clone: cloned))
    }

    @Test func canonicalFourNodeRing() async throws {
        // 1 - 2
        // |   |
        // 4 - 3
        let n1 = GraphNode(1)
        let n2 = GraphNode(2)
        let n3 = GraphNode(3)
        let n4 = GraphNode(4)
        n1.neighbours = [n2, n4]
        n2.neighbours = [n1, n3]
        n3.neighbours = [n2, n4]
        n4.neighbours = [n1, n3]

        let cloned = CloneGraph.perform(n1)
        #expect(verifyDeepClone(original: n1, clone: cloned))
    }

    @Test func mutatingCloneDoesNotAffectOriginal() async throws {
        let n1 = GraphNode(1)
        let n2 = GraphNode(2)
        n1.neighbours = [n2]
        n2.neighbours = [n1]

        guard let cloned = CloneGraph.perform(n1) else {
            Issue.record("Expected non-nil clone")
            return
        }

        cloned.neighbours = []                 // mutate clone
        #expect(n1.neighbours.count == 1)      // original intact
        #expect(n1.neighbours.first === n2)
    }
}
