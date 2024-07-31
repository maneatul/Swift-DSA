import Foundation

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
            
            if heap[index] > heap[parentIndex] {
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
            if leftChildIndex < count && heap[leftChildIndex] > heap[smallestIndex] {
                smallestIndex = leftChildIndex
            }
            
            if rightChildIndex < count && heap[rightChildIndex] > heap[smallestIndex] {
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

struct PriorityQueueElement: Comparable {
    
    var vertex: String
    var weight: Int
    
    static func < (lhs: PriorityQueueElement, rhs: PriorityQueueElement) -> Bool {
        lhs.weight < rhs.weight
    }
    
    static func == (lhs: PriorityQueueElement, rhs: PriorityQueueElement) -> Bool {
        lhs.weight == rhs.weight && lhs.vertex == rhs.vertex
    }

}

class Graph {
    
    var adjacencyList: [String: [(vertex: String, weight: Int)]] = [:]
    
    func addVertex(_ vertex: String) {
        adjacencyList[vertex] = []
    }
    
    func addEdge(from: String, to: String, weight: Int) {
        adjacencyList[from]?.append((vertex: to, weight: weight))
        adjacencyList[to]?.append((vertex: to, weight: weight))
    }
    
    func dijkstra(start: String) -> [String: Int] {
        
        var distances: [String: Int] = [:]
        var priorityQueue = PriorityQueue<PriorityQueueElement>()
        
        for vertex in adjacencyList.keys {
            distances[vertex] = vertex == start ? 0 : Int.max
            
            if vertex == start {
                priorityQueue.push(element: PriorityQueueElement(vertex: vertex, weight: 0))
            }
        }
        
        while let currentElement = priorityQueue.pop() {
            let currentDistance = currentElement.weight
            let currentVertex = currentElement.vertex
            
            if currentDistance > distances[currentVertex]! {
                continue
            }
            
            for neighbor in adjacencyList[currentVertex] ?? [] {
                
                let distance = currentDistance + neighbor.weight
                
                if distance < distances[neighbor.vertex]! {
                    distances[neighbor.vertex] = distance
                    priorityQueue.push(element: PriorityQueueElement(vertex: neighbor.vertex, weight: distance))
                }
            }
        }

        return distances
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

let distances = graph.dijkstra(start: "A")

print(distances)
