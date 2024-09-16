import Foundation


protocol Queueable {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    var peek: Element? { get }
    var isEmpty: Bool { get }
    var count: Int { get }
}

public struct ArrayQueue<T>: Queueable {
    
    private var elements: [T] = []
        
    var head: Int = 0
    
    var count: Int {
        elements.count - head
    }
    
    var isEmpty: Bool {
        head == elements.count
    }
    
    var peek: T? {
        guard !isEmpty else { return nil }
        
        return elements[head]
    }
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        
        guard !isEmpty else { return nil }
        
        defer { head += 1 }
        return elements[head]
    }
}

extension ArrayQueue: CustomStringConvertible {
    
    public var description: String {
        
        return String.init(describing: isEmpty ? [] : elements[head...elements.count-1])
    }
}

var arrayQueue = ArrayQueue<Int>()

arrayQueue.isEmpty
arrayQueue.enqueue(5)
arrayQueue.enqueue(1)
arrayQueue.enqueue(2)
arrayQueue.enqueue(3)
arrayQueue.enqueue(4)
arrayQueue.isEmpty

arrayQueue.description

arrayQueue.dequeue()
arrayQueue.dequeue()
arrayQueue.dequeue()

arrayQueue.enqueue(6)

arrayQueue.description

var arrayQueue1 = ArrayQueue<String>()

arrayQueue1.enqueue("Atul")
arrayQueue1.enqueue("Shivaji")
arrayQueue1.enqueue("Mane")
arrayQueue1.enqueue("Aparna")

arrayQueue1.description

arrayQueue1.dequeue()
arrayQueue1.dequeue()
arrayQueue1.enqueue("Anushree")


arrayQueue1.description


//--------------------------------------------------------------------------------------------


final class SimpleNode<T> {
    
    var data: T
    var next: SimpleNode<T>?
    
    init(data: T, next: SimpleNode<T>? = nil) {
        self.data = data
        self.next = next
    }
}

extension SimpleNode: CustomStringConvertible {
    var description: String{
        guard let next = next else {
            return "\(data)"
        }
        return "\(data) <- \(next) "
    }
}


public struct LinkedListQueue<T> {
    
    
    typealias Node = SimpleNode<T>
    
    private var first: Node?
    private var last: Node?
    
    var length = 0
    
    var isEmpty: Bool {
        length == 0
    }
    
    init() { }
}

extension LinkedListQueue {
    mutating func enqueue(_ element: T) {
        let newNode = Node(data: element)
        
        if isEmpty {
            self.first = newNode
            self.last = newNode
        } else {
            self.last?.next = newNode
            self.last = newNode
        }
        self.length += 1
    }
    
    mutating func dequeue() -> Node? {
        
        guard !isEmpty else {
            debugPrint("can't dequeue from empty Queue!")
            return nil
        }
        if length == 1 {
            self.last = nil
        }
        defer {
            first = first?.next
            self.length -= 1
        }
        
        return self.first
    }
    
}

extension LinkedListQueue: CustomStringConvertible {
    public var description: String {
        if isEmpty {
            return "Queue is empty"
        } else {
            return "\(String.init(describing: first))"
        }
    }
}


var linkedQueue = LinkedListQueue<Int>()

linkedQueue.enqueue(12)
linkedQueue.enqueue(4)
linkedQueue.enqueue(6)

print(linkedQueue)

linkedQueue.dequeue()
linkedQueue.enqueue(8)
print(linkedQueue)

