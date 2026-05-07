//
//  BFSAdjacencyList.swift
//  SwiftDSA
//
//  Created by Ray on 7/5/26.
//

// O(V + E), since we traverse every vertex in worse case, and only its edges due to Adjacency List data structure.
struct BFSAdjacencyList {
    
    static func perform(graph: WeightedAdjacencyList, source: Int, needle: Int) -> [Int]? {
        
        var seen: [Bool] = Array(repeating: false, count: graph.count)
        var prev: [Int] = Array(repeating: -1, count: graph.count)
        
        let q = Queue<Int>()
        q.enqueue(item: source)
        seen[source] = true
        
        // traverse the list
        
        while q.length > 0 {
            let curr = q.deque()!
            if curr == needle { break }
            
            for edge in graph[curr] {
                if seen[edge.to] { continue }
                seen[edge.to] = true
                prev[edge.to] = curr
                q.enqueue(item: edge.to)
            }
        }
        
        if prev[needle] == -1 { return [] }
        
        // decosntruct the BFS
        
        var curr = prev[needle]
        var output: [Int] = [needle]
        
        while curr != -1 {
            output.append(curr)
            curr = prev[curr]
        }
        
        return output.reversed()
    }
}
