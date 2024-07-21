import UIKit

class BinaryTreeNode<T> {
    var left: BinaryTreeNode<T>?
    var data: T
    var right: BinaryTreeNode<T>?
    
    init(left: BinaryTreeNode<T>? = nil, data: T, right: BinaryTreeNode<T>? = nil) {
        self.left = left
        self.data = data
        self.right = right
    }
}

extension BinaryTreeNode: CustomStringConvertible {
    public var description: String {
        "value: \(data), left = [\(left?.description)], right = [\(right?.description)]"
//        "\(data) { \(left?.description), \(right?.description) }"
    }
}

let binaryTreeRoot = BinaryTreeNode(data: 10)

let threeNode = BinaryTreeNode(data: 3)
let fourNode = BinaryTreeNode(data: 4)
let fiveNode = BinaryTreeNode(data: 5)
let sixNode = BinaryTreeNode(data: 6)
let sevenNode = BinaryTreeNode(data: 7)

let eightNode = BinaryTreeNode(data: 8)

binaryTreeRoot.left = threeNode
binaryTreeRoot.right = fourNode

threeNode.left = fiveNode
threeNode.right = sixNode

fiveNode.left = eightNode

fourNode.left = sevenNode


print(binaryTreeRoot)



/// Binary Tree Traversals ( InOrder, PreOrder, PostOrder)
///
/// 1. InOrder
func inOrderTraversal<T>(root: BinaryTreeNode<T>?) {
    if root != nil{
        inOrderTraversal(root: root?.left )
        print("Visit: \(String(describing: root?.data))")
        inOrderTraversal(root: root?.right )
    }
}

/// 1. PreOrder
func preOrderTraversal<T>(root: BinaryTreeNode<T>?) {
    if root != nil{
        print("Visit: \(String(describing: root?.data))")
        preOrderTraversal(root: root?.left )
        preOrderTraversal(root: root?.right )
    }
}

/// 1. PostOrder
func postOrderTraversal<T>(root: BinaryTreeNode<T>?) {
    if root != nil{
        postOrderTraversal(root: root?.left )
        postOrderTraversal(root: root?.right )
        print("Visit: \(String(describing: root?.data))")
    }
}

///find max depth of tree
func findMaxheightOfTree<T>(root: BinaryTreeNode<T>?)-> Int {
    
    if root != nil {
        let leftHeight = findMaxheightOfTree(root: root?.left)
        let rightHeight = findMaxheightOfTree(root: root?.right)
        return max(leftHeight, rightHeight) + 1
    }
    return 0
}

/// find Lowest Common Ancestor (LCA) of Binary Tree
func findLCAOfBinaryTree<T>(root: BinaryTreeNode<T>?, a: BinaryTreeNode<T>?, b: BinaryTreeNode<T>?) -> BinaryTreeNode<T>? {
    
    guard root != nil else {
        return root
    }
    
    if (root === a || root === b ) {
        return root
    }
    
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?
    
    left  = findLCAOfBinaryTree(root: root?.left, a: a, b: b)
    right  = findLCAOfBinaryTree(root: root?.right, a: a, b: b)
    
    if left != nil && right != nil {
        return root
    } else {
        return left != nil ? left : right
    }
}


print("-----------INORDER---------------")
inOrderTraversal(root: binaryTreeRoot)

print("-----------PREORDER---------------")
preOrderTraversal(root: binaryTreeRoot)

print("-----------POSTORDER---------------")
postOrderTraversal(root: binaryTreeRoot)

print("-----------Height of TREE---------------")
print(findMaxheightOfTree(root: binaryTreeRoot))

print("-----------LCA of TREE---------------")
print(findLCAOfBinaryTree(root: binaryTreeRoot, a: eightNode, b: sixNode)?.data)
print(findLCAOfBinaryTree(root: binaryTreeRoot, a: fiveNode, b: sevenNode)?.data)
print(findLCAOfBinaryTree(root: binaryTreeRoot, a: fourNode, b: sevenNode)?.data)


print("----------------------------------------------------------------------------------------")

let btRoot = BinaryTreeNode(data: "A")

let bNode = BinaryTreeNode(data: "B")
let cNode = BinaryTreeNode(data: "C")

let dNode = BinaryTreeNode(data: "D")
let eNode = BinaryTreeNode(data: "E")

let fNode = BinaryTreeNode(data: "F")
let gNode = BinaryTreeNode(data: "G")

let hNode = BinaryTreeNode(data: "H")
let iNode = BinaryTreeNode(data: "I")

btRoot.left = bNode
btRoot.right = cNode

bNode.right = dNode

cNode.left = eNode
cNode.right = fNode

eNode.left = gNode

fNode.left = hNode
fNode.right = iNode

print(btRoot)

print("-----------INORDER---------------")
inOrderTraversal(root: btRoot)

print("-----------PREORDER---------------")
preOrderTraversal(root: btRoot)

print("-----------POSTORDER---------------")
postOrderTraversal(root: btRoot)

print("-----------Height of TREE---------------")
print(findMaxheightOfTree(root: btRoot))


print("-----------LCA of TREE---------------")
print(findLCAOfBinaryTree(root: btRoot, a: gNode, b: iNode)?.data)
print(findLCAOfBinaryTree(root: btRoot, a: dNode, b: iNode)?.data)
print(findLCAOfBinaryTree(root: btRoot, a: hNode, b: iNode)?.data)
