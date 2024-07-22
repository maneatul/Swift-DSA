import UIKit

class BSTNode<T: Comparable> {
    var data: T
    var left: BSTNode<T>?
    var right: BSTNode<T>?
    
    init(data: T, left: BSTNode<T>? = nil, right: BSTNode<T>? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }
}

extension BSTNode: CustomStringConvertible {
    public var description: String {
        "value: \(data), left = [\(left?.description)], right = [\(right?.description)]"
        //        "\(data) { \(left?.description), \(right?.description) }"
    }
}


struct BinarySearchTree<T: Comparable> {
    
    var root: BSTNode<T>?
    
    var count: Int = 0
    
    
    mutating func insert(value: T) {
        root = insertHelper(root, value)
    }
    
    private func insertHelper(_ node: BSTNode<T>?, _ value: T) -> BSTNode<T> {
        guard let node = node else {
            return BSTNode<T>(data: value)
        }
        
        if value < node.data {
            node.left = insertHelper(node.left, value)
        } else {
            node.right = insertHelper(node.right, value)
        }
        
        return node
    }
    
    func removeElement(element: T) -> BSTNode<T>? {
        return removeElement(root: root, element: element)
    }
    
    func removeElement(root: BSTNode<T>? , element: T) -> BSTNode<T>? {
        
        if root == nil {
            return root
        }
        
        if element < root!.data {
            root?.left = removeElement(root: root?.left, element: element)
        }
        else if element > root!.data {
            root?.right = removeElement(root: root?.right, element: element)
            
        }
        else {
            if root!.left == nil {
                return root?.right
            } else if root?.right == nil {
                return root?.left
            }
            
            if let smallest = findMinValueInBST(node: root?.right) {
                root?.data = smallest
            }
            
            root?.right = removeElement(root: root?.right, element: root!.data)
        }
        
        return root
    }
    
    
    /// Binary  Search Tree Traversals ( InOrder, PreOrder, PostOrder)
    ///
    /// 1. InOrder
    private func inOrderTraversal(root: BSTNode<T>?) {
        if root != nil{
            inOrderTraversal(root: root?.left )
            print("Visit: \(String(describing: root?.data))")
            inOrderTraversal(root: root?.right )
        }
    }
    
    /// 1. PreOrder
    private func preOrderTraversal(root: BSTNode<T>?) {
        if root != nil{
            print("Visit: \(String(describing: root?.data))")
            preOrderTraversal(root: root?.left )
            preOrderTraversal(root: root?.right )
        }
    }
    
    /// 1. PostOrder
    private func postOrderTraversal(root: BSTNode<T>?) {
        if root != nil{
            postOrderTraversal(root: root?.left )
            postOrderTraversal(root: root?.right )
            print("Visit: \(String(describing: root?.data))")
        }
    }
    
    func printInorder() {
        inOrderTraversal(root: root)
    }
    
    func printPreorder() {
        preOrderTraversal(root: root)
    }
    
    func printPostorder() {
        postOrderTraversal(root: root)
    }
    
    func levelOrderTraversal() {
        guard let newRoot = root else { return }
        
        var queue: [BSTNode<T>] = [newRoot]
        
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            print("Visited: ", currentNode.data)
            
            if let left = currentNode.left {
                queue.append(left)
            }
            if let right = currentNode.right {
                queue.append(right)
            }
            
        }
        
    }
    
    func searchElement(value: T) -> BSTNode<T>? {
        return search(node: root, value: value)
    }
    
    private func search(node: BSTNode<T>?, value: T) -> BSTNode<T>? {
        guard let node = node else { return nil }
        
        if node.data == value {
            return node
        } else if value < node.data {
            return search(node: node.left, value: value)
        } else {
            return search(node: node.right, value: value)
        }
    }
    
    func findHeightOfBST() -> Int {
        
        return height(root: root)
    }
    
    private func height(root: BSTNode<T>?) -> Int {
        
        if root != nil {
            let leftHeight = height(root: root?.left)
            let rightHeight = height(root: root?.right)
            return max(leftHeight, rightHeight) + 1
            
        }
        return 0
    }
    
    func findLCAofBST(val1: T, val2: T) -> BSTNode<T>? {
        return lca(root: root, val1: val1, val2: val2)
    }
    
    private func lca(root: BSTNode<T>?, val1: T, val2: T) -> BSTNode<T>? {
        
        guard let node = root else { return nil }
        
        if node.data > val1 && node.data > val2 {
            return lca(root: node.left, val1: val1, val2: val2)
        }
        
        if node.data < val1 && node.data < val2 {
            return lca(root: node.right, val1: val1, val2: val2)
        }
        return node
    }
    
    func findMaxValueInBST() -> T? {
        
        var node = root
        while( node?.right != nil) {
            node = node?.right
        }
        return node?.data
    }
    
    func findMinValueInBST(node: BSTNode<T>?) -> T? {
        
        if node == nil {
            return nil
        }
        
        var node = node
        
        while( node?.left != nil) {
            node = node?.left
        }
        return node?.data
    }
    
    func isValidBST(root: BSTNode<T>?) -> Bool {
        return isBST(root: root, min: nil, max: nil)
    }
    
    private func isBST(root: BSTNode<T>?, min: T?, max: T?) -> Bool {
        
        if root == nil { return true }
        
        if min != nil && root!.data <= min! { return false}
        if max != nil && root!.data >= max! { return false}
        
        if(!isBST(root: root?.left, min: min, max:  root?.data)) { return false }
        if(!isBST(root: root?.right, min: root?.data, max: max)) { return false}
        
        return true
    }
}


var bst = BinarySearchTree<Int>()
bst.insert(value: 5)
bst.insert(value: 7)
bst.insert(value: 4)
bst.insert(value: 6)
bst.insert(value: 8)
bst.insert(value: 3)

bst.printInorder()
print("------------------------------------")
bst.removeElement(element: 7)
print(bst.root)

print("Height of BST is: ", bst.findHeightOfBST())

print("Max value in BST : ", bst.findMaxValueInBST())
print("Min value in BST : ", bst.findMinValueInBST(node: bst.root))

if let value = bst.findLCAofBST(val1: 6, val2: 6)?.data {
    print("LCA is \(value)!")
} else {
    print("LCA not found!")
}


if let value = bst.searchElement(value: 5)?.data {
    print("value \(value) found!")
} else {
    print("value not found!")
}

//print("Is Valid BST: ", bst.isValidBST(root: bst.root))





/// validate BST with another example

let fiveRootNode = BSTNode<Int>(data: 5)

let threeNode = BSTNode<Int>(data: 3)
let fourNode = BSTNode<Int>(data: 4)
let sixNode = BSTNode<Int>(data: 6)
let sevenNode = BSTNode<Int>(data: 7)
let eightNode = BSTNode<Int>(data: 8)


fiveRootNode.left = fourNode
fiveRootNode.right = sevenNode

fourNode.left = threeNode

sevenNode.left = sixNode
sevenNode.right = eightNode

print("Is Valid BST: ", bst.isValidBST(root: fiveRootNode))


