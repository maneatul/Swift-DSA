import Foundation

func quickSort(array: [Int]) -> [Int] {
    
    guard array.count > 1 else { return array }
    
    let pivot = array[0] //array[array.count/2]
    
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    print("on Iteration: ", less, equal, greater)
    return quickSort(array: less) + equal + quickSort(array: greater)
}

print(quickSort(array: [3, 8, 2, 5, 9, 6]))
