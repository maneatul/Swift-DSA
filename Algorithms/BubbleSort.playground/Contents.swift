import Foundation

var array: [Int] = [5,7,3,8,1,9,6]

print(array)

var swapped: Bool = false

repeat {
    swapped = false
    for i in 1..<array.count {
        
        if array[i-1] > array[i] {
            
            let temp = array[i-1]
            array[i-1] = array[i]
            array[i] = temp
             
//            array.swapAt(i-1, i)
            
            swapped = true
        }
    }
} while swapped


print(array)
