//
//  CourseScheduleII.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//
//  LC 210 — Course Schedule II
//
//  There are `numCourses` you must take, labeled 0..<numCourses. Some courses
//  have prerequisites given as pairs `[a, b]` meaning to take course `a` you
//  must first take course `b` (i.e. edge `b -> a`).
//
//  Return any ordering of courses you can take to finish all of them. If it
//  is impossible (the prerequisite graph contains a cycle), return [].
//
//  Examples:
//    numCourses = 2, prerequisites = [[1, 0]]
//      -> [0, 1]
//
//    numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
//      -> [0, 1, 2, 3]   (or [0, 2, 1, 3])
//
//    numCourses = 2, prerequisites = [[1,0],[0,1]]
//      -> []   (cycle)
//
//    numCourses = 1, prerequisites = []
//      -> [0]
//
//  Constraints:
//    1 <= numCourses <= 2000
//    0 <= prerequisites.count <= numCourses * (numCourses - 1)
//    All [a,b] are unique.
//
//  Hints:
//    - This is topological sort. Two standard approaches:
//      a) Kahn's algorithm (BFS): repeatedly take nodes with in-degree 0.
//         If you finish with fewer than numCourses, there's a cycle.
//      b) DFS with three-color marking (white/gray/black): a back-edge to a
//         gray node means a cycle. Append to result on post-order, then
//         reverse.
//    - Build an adjacency list from `b -> a` so you can advance from the
//      prerequisite to the dependent course.
//
//  Domain framing (from study guide):
//    Models payment-step ordering: Check Balance -> Validate Biometrics ->
//    Execute Transfer. The graph captures "must happen before" between steps;
//    a cycle means the flow is mis-specified.
//
//  Target: O(V + E) time, O(V + E) space.

struct CourseScheduleII {

    static func perform(numCourses: Int, prerequisites: [[Int]]) -> [Int] {
        var adjs: [[Int]] = Array(repeating: [], count: numCourses)
        for i in 0..<numCourses {
            var connections: [Int] = []
            for prerequisite in prerequisites {
                if prerequisite[1] != i { continue }
                connections.append(prerequisite[0])
            }
            adjs[i] = connections
        }
        
        enum State {
            case fresh, processing, seen
        }
        
        var hasCycle: Bool = false
        var path: [Int] = []
        var states: [State] = Array(repeating: State.fresh, count: numCourses)
        
        func walk(curr: Int) {
            // base case
            if hasCycle { return }
            
            // recurse
            let edges = adjs[curr]
            
            // pre
            states[curr] = .processing
            
            // recurse
            for edge in edges {
                switch states[edge] {
                case .fresh: walk(curr: edge)
                case .seen: continue
                case .processing: hasCycle = true
                }
            }
            
            // post
            path.append(curr)
            states[curr] = .seen
        }
        
        walk(curr: 0)
        
        if hasCycle { return [] }
        
        return path.reversed()
    }
}
