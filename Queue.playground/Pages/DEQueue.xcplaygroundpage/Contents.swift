//: [Previous](@previous)

import Foundation

///Double ended Queue- where enqueue element form rear and dequeue can happen from both side
public struct DEQueue<T> {
    
    private var capacity: Int
    private var elements: NSMutableArray
    
    private var front = -1
    private var rear = -1
    
    public var frontElement: T? {
        guard !isEmpty else {
            debugPrint("DEQueue is Empty")
            return nil
        }
        return elements[front] as? T
    }
    
    public var rearElement: T? {
        guard !isEmpty else {
            debugPrint("DEQueue is Empty")
            return nil
        }
        return elements[rear] as? T
    }
    
    public var isEmpty: Bool{
        front == -1 && rear == -1
    }
    
    public var isFull: Bool {
        (front == rear+1) || (front == 0 && rear == capacity-1)
    }
    
    init(capacity: Int) {
        self.capacity = capacity
        self.elements = NSMutableArray(capacity: capacity)
        
    }
    
    
//    mutating func enqueueFromFront(element: T) {
//        guard !isFull else { debugPrint("DEQueue is Full!!"); return }
//        debugPrint("enqueueFromFront front, rear", front, rear)
//
//        if isEmpty {
//            front = 0
//            rear = 0
//            elements[front] = element
//            return
//        }
//        
//        if front == 0 {
//            front = capacity-1
//            debugPrint("enqueueFromFront front after update", front)
//            elements[front] = element
//        } else {
//            front -= 1
//            elements[front] = element
//        }
//    }
    
    
    mutating func enqueueFromRear(element: T) {
        guard !isFull else { debugPrint("DEQueue is Full!!"); return }
        
        if isEmpty {
            front = 0
            rear = 0
            elements[rear] = element
            return
        }
        if rear == capacity-1 {
            rear = 0
            elements[rear] = element
        } else {
            rear += 1
            elements[rear] = element
        }
    }
    
    mutating func dequeueFromFront() -> T? {
        guard !isEmpty else { debugPrint("DEQueue is Empty"); return nil}
        
        if front == rear {
            defer {
                front = -1
                rear = -1
                }
            return elements[front] as? T
        } else if front == capacity-1 {
            defer{
                front = 0
            }
            return elements[front] as? T
        } else{
            defer {
                front += 1
            }
            return elements[front] as? T
        }
    }
    
    mutating func dequeueFromRear() -> T? {
        guard !isEmpty else { debugPrint("DEQueue is Empty"); return nil}
        
        if front == rear {
            defer {
                front = -1
                rear = -1
                }
            return elements[rear] as? T
        } else if rear == 0 {
            defer {
                rear = capacity-1
            }
            return elements[rear] as? T
        } else {
            defer {
                rear -= 1
            }
            return elements[rear] as? T
        }
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


var deQueue = DEQueue<Int>(capacity: 5)

deQueue.enqueueFromRear(element: 5)
deQueue.enqueueFromRear(element: 4)

deQueue.display()
deQueue.enqueueFromRear(element: 9)

deQueue.display()

deQueue.dequeueFromRear()
deQueue.enqueueFromRear(element: 6)
deQueue.enqueueFromRear(element: 8)
deQueue.dequeueFromFront()
deQueue.dequeueFromFront()

deQueue.frontElement
deQueue.rearElement
deQueue.display()




