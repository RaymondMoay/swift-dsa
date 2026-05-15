//
//  CourseScheduleIIAnswer.swift
//  SwiftDSA
//
//  Created by Ray on 10/5/26.
//

struct CourseScheduleIIAnswer {

    /// Kahn's algorithm (BFS-based topological sort).
    ///
    /// 1. Build adjacency list and in-degree count from prerequisite pairs.
    /// 2. Seed a queue with every course whose in-degree is 0.
    /// 3. Pop from the queue, append to the result, and decrement in-degrees
    ///    of its dependents. When a dependent's in-degree hits 0 it joins the
    ///    queue.
    /// 4. If the result has fewer than `numCourses` entries, the graph has a
    ///    cycle — return [].
    ///
    /// Time:  O(V + E) — every node and edge is visited once.
    /// Space: O(V + E) — adjacency list + in-degree array + queue.
    static func perform(numCourses: Int, prerequisites: [[Int]]) -> [Int] {
        var adjacency: [[Int]] = Array(repeating: [], count: numCourses)
        var inDegree:  [Int]   = Array(repeating: 0,  count: numCourses)

        for pair in prerequisites {
            // pair = [a, b] means b -> a (take b before a).
            let a = pair[0]
            let b = pair[1]
            adjacency[b].append(a)
            inDegree[a] += 1
        }

        var queue: [Int] = []
        for course in 0..<numCourses where inDegree[course] == 0 {
            queue.append(course)
        }

        var order: [Int] = []
        order.reserveCapacity(numCourses)

        var head = 0
        while head < queue.count {
            let course = queue[head]
            head += 1
            order.append(course)

            for next in adjacency[course] {
                inDegree[next] -= 1
                if inDegree[next] == 0 {
                    queue.append(next)
                }
            }
        }

        return order.count == numCourses ? order : []
    }
}
