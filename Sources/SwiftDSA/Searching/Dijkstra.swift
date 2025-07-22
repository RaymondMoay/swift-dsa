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
        var dists = Array(repeating: Int.max, count: graph.count)
        
        /// O(V) runtime
        func hasUnseenVertex(seen: [Bool], dists: [Int]) -> Bool {
            for (index, hasSeen) in seen.enumerated() {
                if !hasSeen && dists[index] < Int.max { // if a vertex has no connections, then it will have dists[index] of Int.max, which we don't want to check...
                    return true
                }
            }
            return false
        }
        
        // this is how we get the curr for our loop
        // O(V) runtime
        func getShortestUnvisited(seen: [Bool], dists: [Int]) -> Int {
            var idx = -1
            var lowestDistance = Int.max
            
            for (index, dist) in dists.enumerated() {
                if seen[index] { // important! without this, we will keep going for the same one... D:
                    continue
                }
                if dist < lowestDistance {
                    lowestDistance = dist
                    idx = index
                }
            }
            
            return idx
        }
        
        // housekeeping
        dists[source] = 0
        
        // O(V^2)
        while(hasUnseenVertex(seen: seen, dists: dists)) {
            let curr = getShortestUnvisited(seen: seen, dists: dists)
            
            // we only go through the edges that exist, not all edges, since this is an adjacencyList.
            // so all in all, we only go through this O(E)
            for edge in graph[curr] {
                let dist = dists[curr] + edge.weight
                if dist < dists[edge.to] {
                    dists[edge.to] = dist
                    prev[edge.to] = curr
                }
            }
            
            seen[curr] = true
        }
        
        // reverse it!
        // O(V)
        var curr = sink
        var out: [Int] = []
        while(prev[curr] != -1) {
            out.append(curr)
            curr = prev[curr]
        }
        
        out.append(source)
        return out.reversed()
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
