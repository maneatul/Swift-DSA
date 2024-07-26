import UIKit

class AVLNode<T: Comparable> {
    var data: T
    var left: AVLNode<T>?
    var right: AVLNode<T>?
    
    init(data: T, left: AVLNode<T>? = nil, right: AVLNode<T>? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }
}

struct AVLTree<T: Comparable> {
    
    var root: AVLNode<T>?

    func height(root: AVLNode<T>?) -> Int {
       
        guard let root = root else { return 0 }
        
        return max(height(root: root.left), height(root: root.right)) + 1
    }
    
    func getBalance(_ node: AVLNode<T>?) -> Int {
        guard let node = node else { return 0 }
        return height(root: node.left) - height(root: root?.right)
    }
    
    
    mutating func insert(value: T) {
        root = insert(node: root, value: value)
    }
    
    private func insert(node: AVLNode<T>?, value: T) -> AVLNode<T>? {
        
        guard let node = node else { return AVLNode(data: value) }
        
        if value < node.data {
            node.left = insert(node: node.left, value: value)
        } else if value > node.data {
            node.right = insert(node: node.right, value: value)
        } else {
            return node
        }
        
        let balance = getBalance(node)
        
        if balance > 1 && value < node.left!.data {
            return rightRotate(root: node)
        }
        
        if balance < -1 && value > node.right!.data {
            return leftRotate(root: node)
        }
        
        if balance > 1 && value > node.left!.data {
            node.left = leftRotate(root: node.left)
            return rightRotate(root: node)
        }
        
        if balance < -1 && value < node.right!.data {
            //node right - right rotation
            //return left rations
            node.right = rightRotate(root: node.right)
            return leftRotate(root: node)
        }
        
        return node
    }
    
    
    //left rotation
    private func leftRotate(root: AVLNode<T>?) -> AVLNode<T>? {
        let y = root?.right
        let z = y?.left
        
        y?.left = root
        root?.right = z
        
        return y
    }
    
    //Right rotate
    private func rightRotate(root: AVLNode<T>?) -> AVLNode<T>? {
        let x = root?.left
        let y = x?.right
        
        x?.right = root
        root?.left = y
        
        return x
    }
    
    mutating func remove(value: T) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<T>?, value: T) -> AVLNode<T>? {
        guard let node = node else { return nil }
        
        if value < node.data {
            node.left = remove(node: node.left, value: value)
        } else if value > node.data {
            node.right = remove(node: node.right, value: value)
        } else {
            
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            }
            
            //node with two childrens: get inorder successor(smallest in right subtree)
            let temp = minValueNode(node: node.right)
            node.data = temp!.data
            node.right = remove(node: node.right, value: temp!.data)
        }
        
        
        let balance = getBalance(node)

        if balance > 1 && getBalance(node.left) >= 0 {
            return rightRotate(root:node)
        }

        if balance > 1 && getBalance(node.left) < 0 {
            node.left = leftRotate(root:node.left)
            return rightRotate(root:node)
        }

        if balance < -1 && getBalance(node.right) <= 0 {
            return leftRotate(root:node)
        }

        if balance < -1 && getBalance(node.right) > 0 {
            node.right = rightRotate(root:node.right)
            return leftRotate(root:node)
        }
        
        
        return node
    }
    
    //find node with minimum value
    func minValueNode(node: AVLNode<T>?) -> AVLNode<T>? {
        var currentNode = node
        
        while currentNode?.left != nil {
            currentNode = currentNode?.left
        }
        return currentNode
    }
    
    func printPreOrder(node: AVLNode<T>?) {
        
        guard let node = node else { return }
        print("Visit: ", node.data)
        printPreOrder(node: node.left)
        printPreOrder(node: node.right)
    }
}



var avlTree = AVLTree<Int>()
avlTree.insert(value: 7)
avlTree.insert(value: 20)
avlTree.insert(value: 5)

avlTree.insert(value: 4)
avlTree.insert(value: 19)

avlTree.insert(value: 3)


avlTree.printPreOrder(node: avlTree.root)
print("--------------------------------")
avlTree.remove(value: 19)
avlTree.printPreOrder(node: avlTree.root)
