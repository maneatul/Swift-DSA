import Foundation


/// Binary Search - 1. Iterative Approach

func binarySearchIterative(array: [Int], target: Int) -> Int? {
    
    var left = 0
    var right = array.count-1
    
    while left <= right {
        let mid = (left + right) / 2 //left + (right-left)/2
        
        if array[mid] == target { return mid } else
        if array[mid] < target {
            left = mid+1
        } else {
            right = mid-1
        }
        
    }
    
    return nil
}

/// Binary Search - 2. Recursive Approach

func binarySearchRecursive(array: [Int], target: Int) -> Int? {
    
    
    return recursiveBSR(array: array, target: target, left: 0, right: array.count-1)
}

func recursiveBSR(array: [Int], target: Int, left: Int, right: Int) -> Int? {
    if left > right {
        return nil
    }
 
    let mid = (left + right) / 2 //left + (right-left)/2
    
    if array[mid] == target {
        return mid
    } else if array[mid] < target {
        return recursiveBSR(array: array, target: target, left: mid+1, right: right)
    } else {
        return recursiveBSR(array: array, target: target, left: left, right: mid-1)
    }
    
}


binarySearchIterative(array: [2,3,5,6,7,9], target: 6)
binarySearchRecursive(array: [2,3,5,6,7,9], target: 7)



func linearSearch(array: [Int], target: Int) -> Int? {
    guard !array.isEmpty else { return nil }
    
    for i in 0...array.count-1 {
        if array[i] == target {
            return i
        }
    }
    return nil
}


linearSearch(array: [2,3,5,6,7,9], target: 4)
