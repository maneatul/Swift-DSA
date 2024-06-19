
import Foundation

public struct CircularQueue<T> {
    
    let elements: NSMutableArray
    let capacity: Int
    
    var count: Int  = 0
    var front: Int = -1
    var rear: Int = -1
    
    var isEmpty: Bool {
        rear == -1 && front == -1
    }
    
    var top: T? {
        guard !isEmpty else { return nil }
        return elements[front] as? T
    }
    var isFull: Bool {
        front == (rear + 1) % capacity
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.elements = NSMutableArray(capacity: capacity)
    }
        
    mutating func enqueue(element: T) {
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
circularQueue.enqueue(element: 4)
circularQueue.enqueue(element: 5)
circularQueue.enqueue(element: 6)
circularQueue.enqueue(element: 7)
circularQueue.enqueue(element: 8)
circularQueue.dequeue()
circularQueue.enqueue(element: 9)
circularQueue.enqueue(element: 2)
circularQueue.display()


circularQueue.top
circularQueue.dequeue()
circularQueue.dequeue()
circularQueue.dequeue()
circularQueue.enqueue(element: 2)
circularQueue.enqueue(element: 1)
circularQueue.dequeue()
circularQueue.enqueue(element: 4)
circularQueue.enqueue(element: 0)
circularQueue.top

circularQueue.display()
circularQueue.count


