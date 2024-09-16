import Foundation

protocol PriorityQueueable {
    associatedtype Element: Comparable
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
    var count: Int { get }
}

struct PriorityQueue<T: Comparable>: PriorityQueueable {
    
    private var heap: [T]
    private let priorityFunction: (T, T) -> Bool

    init(priorityFunction: @escaping (T, T) -> Bool) {
        self.heap = []
        self.priorityFunction = priorityFunction
    }

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    func peek() -> T? {
        return heap.first
    }
    
    func print() {
        debugPrint(heap)
    }
    mutating func enqueue(_ element: T) {
        heap.append(element)
        siftUp(from: heap.count - 1)
    }

    mutating func dequeue() -> T? {
        guard !heap.isEmpty else { debugPrint("PQueue is Empty"); return nil }
        if heap.count == 1 {
            return heap.removeLast()
        } else {
            let value = heap[0]
            heap[0] = heap.removeLast()
            siftDown(from: 0)
            return value
        }
    }

    mutating func changePriority(at index: Int, value: T) {
        guard index < heap.count else { return }
        heap[index] = value
        if !siftUp(from: index) {
            siftDown(from: index)
        }
    }

    private mutating func siftUp(from index: Int) -> Bool {
        var childIndex = index
        let child = heap[childIndex]
        var parentIndex = self.parentIndex(of: childIndex)

        while childIndex > 0 && priorityFunction(child, heap[parentIndex]) {
            heap[childIndex] = heap[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(of: childIndex)
        }
        
        heap[childIndex] = child
        return childIndex != index
    }

    private mutating func siftDown(from index: Int) {
        var parentIndex = index
        let count = heap.count
        let element = heap[parentIndex]

        while true {
            let leftChildIndex = self.leftChildIndex(of: parentIndex)
            let rightChildIndex = self.rightChildIndex(of: parentIndex)
            var first = parentIndex

            if leftChildIndex < count && priorityFunction(heap[leftChildIndex], heap[first]) {
                first = leftChildIndex
            }
            if rightChildIndex < count && priorityFunction(heap[rightChildIndex], heap[first]) {
                first = rightChildIndex
            }

            if first == parentIndex { break }

            heap[parentIndex] = heap[first]
            parentIndex = first
        }
        
        heap[parentIndex] = element
    }

    private func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    private func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }

    private func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
}


var maxHeap = PriorityQueue<Int>(priorityFunction: >)


maxHeap.enqueue(3)
maxHeap.enqueue(5)
maxHeap.enqueue(1)
maxHeap.enqueue(4)
maxHeap.enqueue(8)
maxHeap.enqueue(4)
maxHeap.count
maxHeap.print()

maxHeap.dequeue()
maxHeap.dequeue()
maxHeap.dequeue()
maxHeap.dequeue()
maxHeap.dequeue()

maxHeap.peek()
maxHeap.enqueue(7)
maxHeap.peek()
maxHeap.count
maxHeap.print()


var maxHeap2 = PriorityQueue<Character>(priorityFunction: >)
maxHeap2.enqueue("D")
maxHeap2.enqueue("E")
maxHeap2.enqueue("J")
maxHeap2.enqueue("B")

maxHeap2.dequeue()
 
maxHeap2.peek()
