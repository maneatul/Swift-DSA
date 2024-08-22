import Foundation

var array: [Int] = [5,7,3,8,1,9,6]

print(array)

let n = array.count

for i in 1..<n {
    
    let key = array[i]
    var j = i-1
    
    // Move elements of array[0...i-1] that are greater than 'key' to one position ahead of their current position
    while j >= 0 && array[j] > key {
        
        array[j+1] = array[j]
        j -= 1
    }
    
    // Place the key in its correct position
    array[j+1] = key
}

print(array)
