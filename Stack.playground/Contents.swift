import UIKit
import Foundation

protocol Stack {
    
    associatedtype T
    
    var count: Int { get }
    var isEmpty: Bool { get }
    var top: T? { get }
    
    mutating func push(_ element: T)
    mutating func pop() -> T?
}


public struct StaticStack<T>: Stack {
    
    private let capacity: Int
    private let elements: NSMutableArray
    
    private var stackPointer = 0
    
    public var count: Int {
        stackPointer
    }
    
    var isEmpty: Bool {
        stackPointer == 0
    }
    
    var isFull: Bool {
        count == capacity
    }
    
    var top: T? {
        guard !isEmpty else { return nil }
        
        return elements[stackPointer-1] as? T
    }
    
    public init(capacity: Int) {
        self.capacity = capacity
        self.elements = NSMutableArray(capacity: capacity)
    }
    
    mutating func push(_ element: T) {
        guard !isFull else { fatalError("Stack Overflow!") }
        
        defer { stackPointer += 1 }
        
        self.elements[stackPointer] = element
    }
    
    @discardableResult
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        
        stackPointer -= 1
        
        return elements[stackPointer] as? T
    }
}

public struct DynamicStack<T>: Stack {
    
    private var elements: [T] = []

    public var count: Int {
        elements.count
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var top: T? {
        elements.last
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        elements.popLast()
    }
    
    
}


var staticStack = StaticStack<Int>(capacity: 5)

staticStack.push(4)
staticStack.push(1)
staticStack.push(7)

staticStack.pop()

staticStack.top
staticStack.isFull
staticStack.isEmpty
staticStack.count


var dynamicStack = DynamicStack<Int>()

dynamicStack.push(1)
dynamicStack.push(4)
dynamicStack.push(3)
dynamicStack.push(7)
dynamicStack.push(6)
dynamicStack.push(9)

dynamicStack.count
dynamicStack.top

dynamicStack.pop()
dynamicStack.pop()

dynamicStack.count
dynamicStack.isEmpty
dynamicStack.top

