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
        
        var seen: [Bool] = Array(repeating: false, count: graph.count)
        var path: [Int] = [] // empty, unlike a BFS, which requires backtracking, we have the shape of the function callstack here.
        
        func walk(graph: WeightedAdjacencyList, curr: Int, needle: Int, path: inout [Int], seen: inout [Bool]) -> Bool {
            
            // base case
            if curr == needle {
                path.append(needle)
                return true
            }
            if seen[curr] { return false } // do not walk this again...
            
            // recurse
            
            // pre
            seen[curr] = true
            path.append(curr)
            
            // recurse
            let adjs = graph[curr]
            for edge in adjs {
                if walk(graph: graph, curr: edge.to, needle: needle, path: &path, seen: &seen) {
                    return true
                }
            }
            
            // post
            _ = path.popLast()
            
            return false
        } // finds the path...
        
        _ = walk(graph: graph, curr: source, needle: needle, path: &path, seen: &seen)
        
        if path.isEmpty { return nil }
        return path
    }
}
