import Foundation

class Node<T> {
   
    var data: T
    weak var previous: Node<T>?
    var next: Node<T>?
    
    init(data: T, previous: Node<T>? = nil, next: Node<T>? = nil) {
        self.data = data
        self.previous = previous
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(data)"
        }
        return "\(data) -> \(next) "
    }
}

struct DoublyLinkedList<T: Equatable> {
    
    var count = 0
    
    var head: Node<T>?
    
    var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil || tail == nil
    }
    
    func peekFirst() -> T? {
        head?.data
    }
    
    func peekLast() -> T? {
        tail?.data
    }
    
    mutating func insertAtBeginning(value: T) {
        if isEmpty {
            var newNode = Node(data: value)
            head = newNode
            tail = head
            count += 1
        } else {
            var newNode = Node(data: value)
            head?.previous = newNode
            newNode.next = head
            head = newNode
            count += 1
        }
    }
    
    mutating func insertAtEnd(value: T) {
        if isEmpty {
            var newNode = Node(data: value)
            head = newNode
            tail = head
            count += 1
        } else {
            var newNode = Node(data: value)
            tail?.next = newNode
            newNode.previous = tail
            tail = newNode
            count += 1
        }
    }
    
    mutating func removeAtBeginning() -> T? {
        guard !isEmpty else { debugPrint("List is Empty, Nothing to remove"); return nil }
        
        var removedNode = head
        head = head?.next
        
        if isEmpty {
            tail = nil
        } else {
            head?.previous = nil
        }
        count -= 1
        return removedNode?.data
    }
    
    mutating func removeAtEnd() -> T? {
        guard !isEmpty else { debugPrint("List is Empty, Nothing to remove"); return nil }
        
        var removedNode = tail
        tail = tail?.previous
        if isEmpty {
            head = nil
        } else {
            tail?.next = nil
        }
        count -= 1
        return removedNode?.data
    }
    
    mutating func removeElement(value: T) {
        guard !isEmpty else { debugPrint("List is Empty, Nothing to remove"); return }
        
        var trav = head
        
        repeat{
            if trav?.data == value {
                if trav?.previous == nil {
                    removeAtBeginning()
                } else if trav?.next == nil {
                    removeAtEnd()
                } else {
                    var preNode = trav?.previous
                    var nextNode = trav?.next
                    
                    preNode?.next = nextNode
                    nextNode?.previous = preNode
                    trav = nil
                }
                return
            }
            trav = trav?.next
        } while(trav != nil)
    }
}

var doubleLL = DoublyLinkedList<Int>()
doubleLL.insertAtEnd(value: 6)
doubleLL.insertAtEnd(value: 2)

print(doubleLL.count)
print(doubleLL.head!)


print(doubleLL.head)

doubleLL.insertAtEnd(value: 7)
doubleLL.insertAtBeginning(value: 3)
doubleLL.insertAtBeginning(value: 8)

print(doubleLL.count)
print(doubleLL.head!)
doubleLL.removeElement(value: 7)
print(doubleLL.head!)

doubleLL.removeElement(value: 8)
print(doubleLL)
