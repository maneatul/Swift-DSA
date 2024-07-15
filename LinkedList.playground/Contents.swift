import UIKit

class Node<T> {
    
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}
extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> \(next) "
    }
}


struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool {
        head == nil
    }
    
    init() { }
    
    mutating func insertAtEnd(value: T) {
        if isEmpty {
            head = Node(value: value)
            tail = head
        } else {
            let newNode = Node(value: value)
            tail?.next = newNode
            tail = newNode
        }
    }
    
    mutating func insertAtBeginning(value: T) {
        if isEmpty {
            head = Node(value: value)
            tail = head
        } else {
//            head = Node(value: value, next: head)
            let newNode = Node(value: value)
            newNode.next = head
            head = newNode
        }
    }
    
    mutating func deleteAtBeginning() -> T? {
        guard !isEmpty else {
            debugPrint("Linkedlist is empty, can't delete!!")
            return nil
        }
        
        guard head !== tail else {
            return deleteLastSingleNode()
        }
        
        let removedNode = head
        head = head?.next
        return removedNode?.value
    }
    
    mutating func deleteLastSingleNode() -> T? {
        
        if head?.next == nil {
            var lastNode = head
            head = nil
            tail = nil
            return lastNode?.value
        }
        return nil
    }
    
    mutating func deleteAtEnd() -> T? {
        guard !isEmpty else {
            debugPrint("Linkedlist is empty, can't delete!!")
            return nil
        }
        
        guard head !== tail else {
            return deleteLastSingleNode()
        }
        
        var iterator = head
        
        while(iterator?.next !== tail) {
            
            iterator = iterator?.next
        }
        
        var currentTail = tail
        tail = iterator
        tail?.next = nil
     
        return currentTail?.value
    }
    
    mutating func remove(at index: Int) -> T? {
        guard !isEmpty else {
            debugPrint("List is Empty!")
            return nil
        }
        
        guard head !== tail else {
            return deleteLastSingleNode()
        }
        
        if index == 0 {
            return deleteAtBeginning()
        } else {
            var previousNode = getPreviousNode(index)
            var targetedNode = previousNode?.next
            previousNode?.next = targetedNode?.next
            return targetedNode?.value
        }
    }
    
    private func getPreviousNode(_ index: Int) -> Node<T>? {
        var node = head
        var currentIndex = 0
        
        while (node?.next != nil && currentIndex < index-1){
            node = node?.next
            currentIndex += 1
        }
                
        return node
    }
    
    mutating func insert(_ value: T, at index: Int) {
        if index < 0 {
            debugPrint("invalid index")
        } else if index == 0 {
            insertAtBeginning(value: value)
        }
        
        var newNode = Node(value: value)
        var previousNode = getPreviousNode(index)
        
        newNode.next = previousNode?.next
        previousNode?.next = newNode
    }
    
    mutating func reverse() -> Node<T>? {
        
        guard head?.next != nil else {
            debugPrint("there is only one element in list, so no need to reverse")
            return head
        }
        
        var tempNode: Node<T>?
        var nextNode: Node<T>?
        tail = head
        while((head) != nil) {
            
            nextNode = head?.next
            head?.next = tempNode
            tempNode = head
            head = nextNode
        }
        head?.next = nil
        head = tempNode
        return tempNode
    }
    
    func findNodeFromFront(at index: Int) -> T? {

        if index == 0 {
            return head?.value
        }
        var previousNode = getPreviousNode(index)
        
        return previousNode?.next?.value
    }
    
    func findNodeFromLast(at index: Int) -> T? {
        
        var node = head
        var currentIndex = 0
        var secondIndex = 0
        
        
        while (node?.next != nil) {
           
            if currentIndex >= index {
                secondIndex += 1
            }
            node = node?.next
            currentIndex += 1
        }
        
        return findNodeFromFront(at: secondIndex)
    }
    
}


var linkedList = LinkedList<Int>()

linkedList.insertAtEnd(value: 4)
linkedList.insertAtEnd(value: 6)
linkedList.insertAtEnd(value: 7)
linkedList.insertAtBeginning(value: 9)
linkedList.insertAtBeginning(value: 10)
linkedList.insertAtEnd(value: 12)
print(linkedList)
linkedList.deleteAtBeginning()

linkedList.deleteAtEnd()
linkedList.deleteAtEnd()

linkedList.insertAtEnd(value: 13)
linkedList.insertAtBeginning(value: 11)

linkedList.insert(15, at: 4)
print(linkedList.head ?? "")

linkedList.remove(at: 5)

print(linkedList.head ?? "")
linkedList.reverse()
print(linkedList.head ?? "")
linkedList.findNodeFromFront(at: 0)
linkedList.findNodeFromLast(at: 0)
linkedList.findNodeFromLast(at: 4)

