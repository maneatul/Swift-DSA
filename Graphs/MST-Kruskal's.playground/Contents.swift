import Foundation


class UnionFind {
    
    private var parent: [String: String] = [:]
    
    private var rank: [String: Int] = [:]
    
    func find(_ node: String) -> String {
        
        if parent[node] == nil {
            parent[node] = node
            rank[node] = 0
        }
        
        if parent[node] != node {
            parent[node] = find(parent[node]!)
        }
        return parent[node]!
    }
    
    func union(node1: String, node2: String) {
        let root1 = find(node1)
        let root2 = find(node2)
        
        if root1 != root2 {
            if rank[root1]! > rank[root2]! {
                parent[root2] = root1
                
            } else if  rank[root1]! < rank[root2]! {
                parent[root1] = root2
                
            } else {
                parent[root2] = root1
                rank[root1]! += 1
            }
        }
        
    }
}

struct Edge: Comparable {
    let from: String
    let to: String
    let weight: Int

    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}


class Graph {
    var edges: [Edge] = []
    var vertices: Set<String> = []
    
    func addEdge(from: String, to: String, weight: Int) {
        edges.append(Edge(from: from, to: to, weight: weight))
        vertices.insert(from)
        vertices.insert(to)
    }
    
    func kruskal() -> (mst: [Edge], totalWeight: Int) {
        
        var mst: [Edge] = []
        var totalWeight = 0
        let unionFind = UnionFind()
        
        edges.sort()
        
        for edge in edges {
            let root1 = unionFind.find(edge.from)
            let root2 = unionFind.find(edge.to)
            
            if root1 != root2 {
                
                mst.append(edge)
                totalWeight += edge.weight
                unionFind.union(node1: edge.from, node2: edge.to)
            }
        }
        
        return (mst, totalWeight)
    }
}

let graph = Graph()
graph.addEdge(from: "A", to: "B", weight: 1)
graph.addEdge(from: "A", to: "C", weight: 4)
graph.addEdge(from: "B", to: "C", weight: 2)
graph.addEdge(from: "B", to: "D", weight: 5)
graph.addEdge(from: "C", to: "D", weight: 1)
graph.addEdge(from: "D", to: "E", weight: 3)
graph.addEdge(from: "C", to: "E", weight: 6)

let result = graph.kruskal()
print("Minimum Spanning Tree:")
for edge in result.mst {
    print("\(edge.from) - \(edge.to): \(edge.weight)")
}
print("Total weight: \(result.totalWeight)")
