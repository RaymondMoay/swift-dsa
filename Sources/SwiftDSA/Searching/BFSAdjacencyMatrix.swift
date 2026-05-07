//
//  BFSAdjacencyMatrix.swift
//  SwiftDSA
//
//  Created by Ray on 29/6/25.
//

/// In a BFS adjacency matrix, we are simply doing O(V^2). For every vertex, we are looking at all its connections (VxV).
///
/// Note: Even with a seen array, or with 0 checks for adjacencies, we are still checking if its seen, so that is still V operations per V.
struct BFSAdjacencyMatrix {
    
    typealias WeightedAdjacencyMatrix = [[Int]]
    
    // O(V + E)
    static func perform(graph: [[Int]],
                        source: Int,
                        needle: Int) -> [Int]? {
        
        var seen: [Bool] = .init(repeating: false, count: graph.count)
        var prev: [Int] = .init(repeating: -1, count: graph.count)
        
        seen[source] = true
        let q = Queue<Int>()
        q.enqueue(item: source)
        
        while q.length > 0 {
            // Part 1: Finding from the queue
            guard let curr = q.deque() else { break } // assertion failure, it should never fail here.
            if curr == needle { break }
            
            let adjs = graph[curr]
            
            // Part 2: Adding to the queue
            for i in 0..<adjs.count {
                if adjs[i] == 0 { continue }
                if seen[i] { continue }
                
                seen[i] = true
                prev[i] = curr
                q.enqueue(item: i)
            }
        }
        
        // build it backwards (O(V))
        var path: [Int] = []
        var origin: Int = prev[needle]
        
        while origin != -1 {
            path.append(origin)
            origin = prev[origin]
        }
        
        if path.isEmpty {
            return []
        } else {
            path.insert(needle, at: 0)
            return path.reversed()
        }
    }
}
