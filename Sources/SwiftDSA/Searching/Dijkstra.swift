//
//  Dijkstra.swift
//  SwiftDSA
//
//  Created by Ray on 30/6/25.
//

struct Dijkstra {
    
    static func perform(graph: WeightedAdjacencyList, source: Int, sink: Int) -> [Int] {
        
        var seen = Array(repeating: false, count: graph.count)
        var prev = Array(repeating: -1, count: graph.count)
        var dist = Array(repeating: Int.max, count: graph.count)
        
        dist[source] = 0
        
        func hasUnseenNode() -> Bool {
            seen.enumerated().contains { (i, s) in
                !s && dist[i] < Int.max
            }
        }
        
        func lowestUnseenIndex() -> Int {
            var idx = -1
            var lowest = Int.max
            
            for i in 0..<seen.count {
                if seen[i] { continue }
                if dist[i] < lowest {
                    lowest = dist[i]
                    idx = i
                }
            }
            
            return idx
        }
        
        while hasUnseenNode() {
            let curr = lowestUnseenIndex()
            seen[curr] = true
            
            for e in graph[curr] {
                if seen[e.to] { continue }
                
                let d = e.weight + dist[curr]
                if d < dist[e.to] {
                    dist[e.to] = d
                    prev[e.to] = curr
                }
            }
        }
        
        // reverse
        var curr = prev[sink]
        var output: [Int] = [sink]
        
        while curr != -1 {
            output.append(curr)
            curr = prev[curr]
        }
        
        return output.reversed()
    }
}
// total runtime = O(V^2 + E) <- this is bad!

/// so how can we make it better?
/// first, `hasUnseenVertex` can be replaced with a minHeap (a heap is a priority queue),
/// This means that once we pop off the head, we won't see it again! So this effecively replaces the entire function,
/// and removes the need of a seen array. Also, now runtime is O(Log(n)) since thats the runtime when we pop the head!
///
/// How about `getShortestUnvisited`?
/// Well this function gets the SHORTEST path, again its a minHeap.
///
/// So how do we do this?
///
/// We just have to build the minHeap out of the distances and its index.
/// Something like Node = { id: source, distance: 0 }.
///
/// Then instead of `hasUnseenVertex`, we just check the length of the distances array, or if we keep popping it until we hit Int.max as the distance of the popped vertex.
///
/// This will turn the entire operation into O(

// TODO: Improve Dijkstra with a minHeap
