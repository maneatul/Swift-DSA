import Foundation

struct Edge {
    let from: String
    let to: String
    let weight: Int
}


class Graph {
    
    var vertices: [String] = []
    var edges: [Edge] = []
    
    
    func addVertex(_ vertex: String) {
        if !vertices.contains(vertex) {
            vertices.append(vertex)
        }
    }
    
    func addEdge(from: String, to: String, weight: Int) {
        let edge = Edge(from: from, to: to, weight: weight)
        edges.append(edge)
        addVertex(from)
        addVertex(to)
    }
    
    func bellmanFord(start: String) -> (distances: [String: Int], hasNegativeCycle: Bool){
        
        var distances = [String: Int]()
        var predecessors = [String: String]()
        
        
        for vertex in vertices {
            distances[vertex] = vertex == start ? 0 : Int.max
        }
        
        for _ in 1..<vertices.count {
            for edge in edges {
                if let distanceFrom = distances[edge.from], distanceFrom != Int.max {
                    let newDistance = distanceFrom + edge.weight
                    
                    if newDistance < distances[edge.to]! {
                        distances[edge.to] = newDistance
                        predecessors[edge.to] = edge.from
                    }
                }
            }
        }
        
        for edge in edges {
            if let distanceFrom = distances[edge.from], distanceFrom != Int.max {
                if distanceFrom + edge.weight < distances[edge.to]! {
                    return (distances, true)
                }
            }
        }
        
        return (distances, false)
    }
}

let graph = Graph()
graph.addEdge(from: "A", to: "B", weight: 1)
graph.addEdge(from: "A", to: "C", weight: 4)
graph.addEdge(from: "B", to: "C", weight: 2)
graph.addEdge(from: "B", to: "D", weight: 5)
graph.addEdge(from: "C", to: "D", weight: 1)
graph.addEdge(from: "D", to: "E", weight: 3)
//graph.addEdge(from: "E", to: "B", weight: -10) // Negative weight edge to create a cycle

let result = graph.bellmanFord(start: "A")
if result.hasNegativeCycle {
    print("Graph contains a negative weight cycle")
} else {
    print("Shortest distances from A: \(result.distances)")
}
