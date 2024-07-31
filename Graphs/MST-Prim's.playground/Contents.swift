import Foundation

/// Min Heap Priority Queue
struct PriorityQueue<T: Comparable> {
    
     var heap = [T]()
    
    mutating func push(element: T) {
        heap.append(element)
        shiftUP(index: heap.count - 1)
    }
    
    mutating func shiftUP(index: Int) {
        var index = index
        while index > 0 {
            let parentIndex = (index-1)/2
            
            if heap[index] < heap[parentIndex] {
                heap.swapAt(index, parentIndex)
                index = parentIndex
            } else {
                break
            }
        }
    }
    
    mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        
        if heap.count == 1 {
            return heap.removeLast()
        } else {
            let root = heap[0]
            heap[0] = heap.removeLast()
            shiftDown(from: 0)
            return root
        }
    }
    
    mutating func shiftDown(from index: Int) {
        
        var index = index
        let count = heap.count
        
        while index < count {
            let leftChildIndex = 2 * index + 1
            let rightChildIndex = 2 * index + 2
            
            var smallestIndex = index
            if leftChildIndex < count && heap[leftChildIndex] < heap[smallestIndex] {
                smallestIndex = leftChildIndex
            }
            
            if rightChildIndex < count && heap[rightChildIndex] < heap[smallestIndex] {
                smallestIndex = rightChildIndex
            }
            
            if smallestIndex == index {
                break
            }
            heap.swapAt(index, smallestIndex)
            index = smallestIndex
        }
        
    }
    
}

struct Edge {
    let from: String
    let to: String
    let weight: Int
}

struct PriorityQueueElement: Comparable {
    
    var edge: Edge
    var weight: Int
    
    static func < (lhs: PriorityQueueElement, rhs: PriorityQueueElement) -> Bool {
        lhs.weight < rhs.weight
    }
    
    static func == (lhs: PriorityQueueElement, rhs: PriorityQueueElement) -> Bool {
        lhs.weight == rhs.weight && lhs.edge.from == rhs.edge.from && lhs.edge.to == rhs.edge.to
    }
}


class Graph {
    
    var adjacencyList: [String : [(vertex: String, weight: Int)]] = [:]
    
    func addVertex(_ vertex: String) {
        adjacencyList[vertex] = []
    }
    
    func addEdge(from: String, to: String, weight: Int) {
        adjacencyList[from]?.append((vertex: to, weight: weight))
        adjacencyList[to]?.append((vertex: from, weight: weight)) // for undirected graph
    }
    
    func prims(start: String) -> (mst: [Edge], totalWeight: Int) {
        
        var mst = [Edge]()
        var totalWeight: Int = 0
        
        var visited = Set<String>()
        var priorityQueue = PriorityQueue<PriorityQueueElement>()
        
        func addEdge(from vertex: String) {
            visited.insert(vertex)
            for neighbor in adjacencyList[vertex] ?? [] {
                if !visited.contains(neighbor.vertex) {
                    priorityQueue.push(element: PriorityQueueElement(edge: Edge(from: vertex, to: neighbor.vertex, weight: neighbor.weight), weight: neighbor.weight))
                }
            }
        }
        
        addEdge(from: start)
        
        
        while let popElement = priorityQueue.pop() {
            if visited.contains(popElement.edge.to) {
                continue
            }
            
            mst.append(popElement.edge)
            totalWeight += popElement.weight
            addEdge(from: popElement.edge.to)
        }
        
        return (mst, totalWeight)
    }
}

let graph = Graph()
graph.addVertex("A")
graph.addVertex("B")
graph.addVertex("C")
graph.addVertex("D")
graph.addVertex("E")
graph.addEdge(from: "A", to: "B", weight: 1)
graph.addEdge(from: "A", to: "C", weight: 4)
graph.addEdge(from: "B", to: "C", weight: 2)
graph.addEdge(from: "B", to: "D", weight: 5)
graph.addEdge(from: "C", to: "D", weight: 1)
graph.addEdge(from: "D", to: "E", weight: 3)
graph.addEdge(from: "C", to: "E", weight: 6)

let result = graph.prims(start: "A")
print("Minimum Spanning Tree:")
for edge in result.mst {
    print("\(edge.from) - \(edge.to): \(edge.weight)")
}
print("Total weight: \(result.totalWeight)")
