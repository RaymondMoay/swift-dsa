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
    static func perform(graph: [[Int]], source: Int, needle: Int) -> [Int]? {
        
        var seen = Array(repeating: false, count: graph.count)
        var prev = Array(repeating: -1, count: graph.count)
        
        let q = Queue<Int>()
        q.enqueue(item: source)
        seen[source] = true
        
        while q.length > 0 {
            // visit the node
            guard let curr = q.deque() else { break }
            if curr == needle { break }
            
            // traverse its edges
            let adjs = graph[curr]
            for i in 0..<adjs.count {
                if adjs[i] == 0 { continue }
                if seen[i] { continue }
                
                seen[i] = true
                prev[i] = curr
                q.enqueue(item: i)
            }
        }
        
        // deconstruct now
        
        if prev[needle] == -1 { return [] }
        
        var curr = prev[needle]
        var output: [Int] = [needle]
        while curr != -1 {
            output.append(curr)
            curr = prev[curr]
        }
        
        return output.reversed()
    }
}
