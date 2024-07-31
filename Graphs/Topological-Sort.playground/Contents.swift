import UIKit

class Graph {
    
    var adjacencyList: [String: [String]] = [:]
    
    
    func addVertex(_ vertex: String) {
        adjacencyList[vertex] = []
    }
    
    func addEdge(from: String, to: String) {
        adjacencyList[from]?.append(to)
    }
    
    
    func topologicalSort() -> [String] {
        
        var visited = Set<String>()
        var stack = [String]()
        
        
        for vertex in adjacencyList.keys {
            if !visited.contains(vertex) {
                topologicalSortHelper(vertex, visited: &visited, stack: &stack)
            }
        }
        
        return stack.reversed()
    }
    
    func topologicalSortHelper(_ vertex: String, visited: inout Set<String>, stack: inout [String]) {
        visited.insert(vertex)
        
        for neighbor in adjacencyList[vertex] ?? [] {
            if !visited.contains(neighbor) {
                topologicalSortHelper(neighbor, visited: &visited, stack: &stack)
            }
        }
        
        stack.append(vertex)
        
    }
}


let graph = Graph()
graph.addVertex("A")
graph.addVertex("B")
graph.addVertex("C")
graph.addVertex("D")
graph.addVertex("E")
graph.addVertex("F")
graph.addEdge(from: "A", to: "C")
graph.addEdge(from: "B", to: "C")
graph.addEdge(from: "B", to: "D")
graph.addEdge(from: "C", to: "E")
graph.addEdge(from: "E", to: "F")
graph.addEdge(from: "D", to: "F")

let sortedOrder = graph.topologicalSort()
print(sortedOrder)
