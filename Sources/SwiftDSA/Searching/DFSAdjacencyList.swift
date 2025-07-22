//
//  DFSAdjacencyList.swift
//  SwiftDSA
//
//  Created by Ray on 29/6/25.
//

struct GraphEdge {
    
    let to: Int
    let weight: Int
}

typealias WeightedAdjacencyList = [[GraphEdge]]

// O(V + E)
struct DFSAdjacencyList {
    
    static func perform(graph: WeightedAdjacencyList, source: Int, needle: Int) -> [Int]? {
        
        var path: [Int] = []
        var seen: [Bool] = Array(repeating: false, count: graph.count)
        
        func walk(graph: WeightedAdjacencyList,
                  curr: Int,
                  needle: Int,
                  seen: inout [Bool],
                  path: inout [Int]) -> Bool {
            
            // base case
            
            // 1. have i seen you before?
            if seen[curr] {
                return false
            }
            
            // 2. are you my needle?
            if curr == needle {
                path.append(curr)
                return true
            }
            
            // recurse
            
            // 1. pre
            seen[curr] = true
            path.append(curr)
            
            // 2. recurse
            let edges = graph[curr]
            for edge in edges {
                if walk(graph: graph,
                        curr: edge.to,
                        needle: needle,
                        seen: &seen,
                        path: &path) {
                    return true
                }
            }
            
            // 3. pop
            _ = path.popLast()
            return false
        }
        
        _ = walk(graph: graph,
                 curr: source,
                 needle: needle,
                 seen: &seen,
                 path: &path)
        
        if path.isEmpty {
            return nil
        } else {
            return path
        }
    }
}
