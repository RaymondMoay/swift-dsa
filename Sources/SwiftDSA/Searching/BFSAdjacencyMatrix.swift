//
//  BFSAdjacencyMatrix.swift
//  SwiftDSA
//
//  Created by Ray on 29/6/25.
//

/// In a BFS adjacency matrix, we are simply doing O(N), iterating through every vertex and making sure we only do it once with `seen`.
///
/// We are also ignoring the weights, just building the path required to get to the needle.
///
/// seen = [t,f,f,f,f] where first is a true to indicate that the source is true.
/// prev = [-1,-1,-1,-1,-1], where -1 means there are no previous vertex. Here, we are storing the previous index of the vertex path.
struct BFSAdjacencyMatrix {
    
    typealias WeightedAdjacencyMatrix = [[Int]]
    
    // O(V + E)
    static func perform(graph: [[Int]],
                        source: Int,
                        needle: Int) -> [Int]? {
        
        var seen = Array(repeating: false, count: graph.count)
        var prev = Array(repeating: -1, count: graph.count)
        
        let queue = Queue<Int>()
        queue.enqueue(item: source)
        seen[source] = true
        
        while(queue.length > 0) {
            
            let curr = queue.deque()!
            
            if curr == needle {
                break
            }
            
            let adjs = graph[curr]
            for i in 0..<adjs.count {
                if adjs[i] == 0 { continue }
                if seen[i] { continue }
                
                prev[i] = curr
                seen[i] = true
                queue.enqueue(item: i)
            }
        }
        
        // reverse!
        var curr = needle
        var out: [Int] = []
        while(prev[curr] != -1) {
            out.append(curr)
            curr = prev[curr]
        }
        
        if out.isEmpty {
            return []
        } else {
            out.append(source)
            return out.reversed()
        }
    }
}
