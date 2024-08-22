import UIKit

var array: [Int] = [5,7,3,8,1,9,6]

print("UnSorted:",array)

for i in 0..<array.count {
    
    var minIndex = i
    
    for j in (i+1)..<array.count {
        
        if array[j] < array[minIndex] {
            minIndex = j
        }
    }
    
    if i != minIndex {
        array.swapAt(i, minIndex)
    }
    
}

print("Sorted:",array)
