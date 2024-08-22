import Foundation


func mergeSort(_ array: [Int]) -> [Int] {
    
    guard array.count > 1 else { return array }
    
    let middleIndex = array.count/2
    
    /// Divide the array into two sub array
    let leftArray = Array(array[..<middleIndex])
    let rightArray = Array(array[middleIndex...])
    
    /// Recursively sort each half and then merge
    return merge(mergeSort(leftArray), mergeSort(rightArray))
}


/// function to merge two sub arrays
func merge(_ leftArray: [Int], _ rightArray: [Int]) -> [Int] {
    var merge: [Int] = []
    var leftIndex = 0
    var rightIndex = 0
    
    while (leftIndex < leftArray.count && rightIndex < rightArray.count) {
        if leftArray[leftIndex] < rightArray[rightIndex] {
            merge.append(leftArray[leftIndex])
            leftIndex += 1
        } else {
            merge.append(rightArray[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < leftArray.count {
        merge.append(leftArray[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightArray.count {
        merge.append(rightArray[rightIndex])
        rightIndex += 1
    }
    
    return merge
}


print(mergeSort([4,2,6,5,8,7]))
print(mergeSort([38, 27, 43, 3, 9, 82, 10]))
