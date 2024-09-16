
import Foundation

protocol Queueable {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
    var peek: Element? { get }
    var isEmpty: Bool { get }
    var count: Int { get }
}

public struct CircularQueue<T>: Queueable {
    
    let elements: NSMutableArray
    let capacity: Int
    
    var count: Int  = 0
    var front: Int = -1
    var rear: Int = -1
    
    var isEmpty: Bool {
        rear == -1 && front == -1
    }

    var isFull: Bool {
        front == (rear + 1) % capacity
    }
    
    var peek: T? {
        guard !isEmpty else { return nil }
        return elements[front] as? T
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.elements = NSMutableArray(capacity: capacity)
    }
        
    mutating func enqueue(_ element: T) {
        if front == -1 {
                front = 0
                rear = 0
            elements[rear] = element
            count += 1
            return
        }
        
        if isFull {
            debugPrint("Queueu is full!")
            return
        }
        rear = (rear+1) % capacity
        elements[rear] = element
        count += 1
    }

        
    mutating func dequeue() -> T? {
        guard !isEmpty else {
            debugPrint("Queueu is Empty!")
            return nil
        }
        
        if(front == rear) {
            defer {
                front = -1
                rear = -1
            }
        return elements[front] as? T
        }
        
        defer {
            front = (front + 1) % capacity
            count -= 1
        }
        return elements[front] as? T
    }
    
    func display() {
        guard !isEmpty else {
            debugPrint("Queueu is Empty!")
            return
        }
        var i = front
        repeat {
            print(elements[i])
            i = (i + 1) % capacity
        } while(i != rear)
        print(elements[i])

        print("-------------------------------------")
    }
}

var circularQueue = CircularQueue<Int>(capacity: 5)

circularQueue.count
circularQueue.enqueue(4)
circularQueue.enqueue(5)
circularQueue.enqueue(6)
circularQueue.enqueue(7)
circularQueue.enqueue(8)
circularQueue.dequeue()
circularQueue.enqueue(9)
circularQueue.enqueue(2)
circularQueue.display()


circularQueue.peek
circularQueue.dequeue()
circularQueue.dequeue()
circularQueue.dequeue()
circularQueue.enqueue(2)
circularQueue.enqueue(1)
circularQueue.dequeue()
circularQueue.enqueue(4)
circularQueue.enqueue(0)
circularQueue.peek

circularQueue.display()
circularQueue.count


