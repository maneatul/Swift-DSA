import Foundation

class Graph {
    
    var adjacencyList: [String: [String]] = [:]
 
    func addVertex(_ vertex: String ) {
        adjacencyList[vertex] = []
    }
    func addEdge(_ from: String, _ to: String) {
        adjacencyList[from]?.append(to)
        adjacencyList[to]?.append(from) //for undirected graph
    }
    
    func printGraph() {
        for (vertex, neighbors) in adjacencyList {
            print("\(vertex) : \(neighbors)")
        }
    }
    
    func dfs(start: String) -> Set<String> {
        var visited = Set<String>()
        dfsHelper(start: start, visited: &visited)
        return visited
    }
    
    private func dfsHelper(start: String, visited: inout Set<String>) {
        visited.insert(start)
        print(start)
        
        for neighbor in adjacencyList[start] ?? [] {
            
            if !visited.contains(neighbor) {
                dfsHelper(start: neighbor, visited: &visited)
            }
        }
    }
    
    func bfs(start: String) {
        var visited = Set<String>()
        var queue = [start]
        
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            if !visited.contains(vertex) {
                visited.insert(vertex)
                print(vertex)
                for neighbor in adjacencyList[vertex] ?? [] {
                    if !visited.contains(neighbor) {
                        queue.append(neighbor)
                    }
                }
            }
        }
    }
}


let graph = Graph()
graph.addVertex("A")
graph.addVertex("B")
graph.addVertex("C")
graph.addVertex("D")
graph.addVertex("E")
graph.addVertex("F")
graph.addVertex("G")
graph.addVertex("H")

graph.addEdge("A", "B")
graph.addEdge("B", "C")
graph.addEdge("C", "D")
graph.addEdge("B", "H")
graph.addEdge("C", "E")
graph.addEdge("H", "E")
graph.addEdge("E", "F")
graph.addEdge("E", "G")


graph.printGraph()
print("--------------------------------")
graph.dfs(start: "A")
print("--------------------------------")
graph.bfs(start: "A")


