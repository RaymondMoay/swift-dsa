//
//  DFSAdjacencyMatrix.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

struct DFSAdjacencyMatrix {
    
    typealias WeightedAdjacencyMatrix = [[Int]]
    
    // O(V + E)
    static func perform(graph: [[Int]], source: Int, needle: Int) -> [Int]? {
        
        var seen: [Bool] = Array(repeating: false, count: graph.count)
        var path: [Int] = []
        
        func walk(graph: [[Int]], curr: Int, needle: Int) -> Bool {
            // base
            if curr == needle {
                path.append(needle)
                return true
            }
            if seen[curr] { return false }
            
            // recursion
            
            // pre
            seen[curr] = true
            path.append(curr)
            
            // recurse
            let adjs = graph[curr]
            for i in 0..<adjs.count {
                if adjs[i] == 0 { continue }
                if walk(graph: graph, curr: i, needle: needle) {
                    return true
                }
            }
            
            // post
            _ = path.popLast()
            return false
        }
        
        _ = walk(graph: graph, curr: source, needle: needle)
        
        return path
    }
}
