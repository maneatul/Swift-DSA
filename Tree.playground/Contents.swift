import UIKit

class TreeNode<T> {
    var data: T
    var parent: TreeNode<T>?
    var childs:[TreeNode<T>] = []
    
    init(data: T, parent: TreeNode<T>? = nil, childs: [TreeNode<T>] = []) {
        self.data = data
        self.parent = parent
        self.childs = childs
    }
}

extension TreeNode: CustomStringConvertible {
    
    public var description: String {
        var value = "\(data)"
        if !childs.isEmpty {
            value += " {" + childs.map { $0.description }.joined(separator: ", ") + " }"
        }
        return value
    }
}

extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        if value == self.data {
            return self
        }
        
        for child in childs {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}



let tree = TreeNode(data: 8)

let fiveNode = TreeNode(data: 5)
let nineNode = TreeNode(data: 9)

let sixNode = TreeNode(data: 6)
let tenNode = TreeNode(data: 10)


tree.childs.append(fiveNode)
tree.childs.append(nineNode)

tree.childs.append(sixNode)
nineNode.childs.append(tenNode)


print(tree)

if let element = tree.search(1) {
    print("element \(element) found!")

} else {
    print("element not found!")
}
