//
//  DijkstraAnswers.swift
//  SwiftDSA
//
//  Created by Ray on 2/7/25.
//

struct DijkstraAnswers {
    
    static func perform(graph: WeightedAdjacencyList, source: Int, sink: Int) -> [Int] {
        
        func hasUnvisited(seen: [Bool], dists: [Int]) -> Bool {
            for (index, hasSeen) in seen.enumerated() {
                if !hasSeen && dists[index] < Int.max { // make sure that not only we see everything, but we make sure to find the shortest path to each node.
                    return true
                }
            }
            return false
        }
        
        func getLowestUnvisited(seen: [Bool], dists: [Int]) -> Int {
            var idx = -1
            var lowestDistance = Int.max
            
            for i in 0..<dists.count {
                if seen[i] {
                    continue
                }
                
                if lowestDistance > dists[i] { // impossible that this doesn't run until seen is fully filled, because lowest distance starts at the max.
                    lowestDistance = dists[i]
                    idx = i
                }
            }
            
            return idx
        }
        
        var seen = Array(repeating: false, count: graph.count)
        var dists = Array(repeating: Int.max, count: graph.count)
        var prev = Array(repeating: -1, count: graph.count)
        dists[source] = 0
        
        while (hasUnvisited(seen: seen, dists: dists)) {
            let curr = getLowestUnvisited(seen: seen, dists: dists)
            seen[curr] = true
            let edges = graph[curr]
            for edge in edges {
                /// which edge should i check?
                if seen[edge.to] { // i've checked before, move on
                    continue
                }
                
                let dist = dists[curr] + edge.weight // dijkstra's magic...
                if dist < dists[edge.to] {
                    dists[edge.to] = dist
                    prev[edge.to] = curr
                }
            }
        }
        
        var out: [Int] = []
        var current = sink
        
        while(prev[current] != -1) {
            out.append(current)
            current = prev[current] // who was the last person who added me in to the shortest path?
        }
        
        out.append(source)
        return out.reversed()
    }
}
