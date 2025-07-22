//
//  BFSAdjacencyMatrixAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 29/6/25.
//

struct BFSAdjacencyMatrixAnswers {
    
    typealias WeightedAdjacencyMatrix = [[Int]]
    
    static func perform(graph: [[Int]],
                        source: Int,
                        needle: Int) -> [Int]? {
        
        var seen: [Bool] = Array(repeating: false, count: graph.count)
        var prev: [Int] = Array(repeating: -1, count: graph.count)
        
        let queue = Queue<Int>()
        queue.enqueue(item: source)
        seen[source] = true
        
        while (queue.length > 0) {
            let curr = queue.deque()!
            
            if curr == needle {
                break
            }
            
            let adjs = graph[curr]
            for i in 0..<adjs.count {
                /// see which vertex i can walk
                
                // if i have seen this vertex, ignore
                if seen[i] {
                    continue
                }
                
                // if this vertex is not linked, ignore
                if adjs[i] == 0 {
                    continue
                }
                
                // otherwise, add it to queue so i can check its edges
                queue.enqueue(item: i)
                prev[i] = curr // set its previous to the current
                seen[i] = true // and set it to seen, so i don't add it to the queue again
            }
            seen[curr] = true
        }
        
        // deconstruct
        
        var curr = needle
        var out: [Int] = []
        while(prev[curr] != -1) {
            out.append(curr)
            curr = prev[curr]
        }
        
        if out.isEmpty {
            return nil
        } else {
            return [source] + out.reversed()
        }
    }
}
