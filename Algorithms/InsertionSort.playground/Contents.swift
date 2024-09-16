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


func mergeAlternately(_ word1: String, _ word2: String) -> String {
    var result = ""
    let minCount = min(word1.count, word2.count)
    
    let charArray1 = Array(word1)
    let charArray2 = Array(word2)
    
    for i in 0..<minCount {
        result += "\(charArray1[i])"
        result += "\(charArray2[i])"
    }
    
    if word1.count == minCount {
        result += String(charArray2[minCount...])
    } else {
        result += String(charArray1[minCount...])
    }
    return result
}

//print(mergeAlternately("abc", "pqr"))


func gcdOfStrings(_ str1: String, _ str2: String) -> String {
    
    if str1 == str2 {
        return str1
    }
    
    if str2.count > str1.count {
        return gcdOfStrings(str2, str1)
    }
    
    if str1.starts(with: str2) {
        return gcdOfStrings(str1, str2)
    }
    return ""
}

func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {

    var result = [Bool]()
    
    let maxVal = candies.max() ?? 0
    
    for candy in candies {
        result.append((candy+extraCandies) >= maxVal)
    }
    return result
}

print(kidsWithCandies([2,3,5,1,3], 3))
