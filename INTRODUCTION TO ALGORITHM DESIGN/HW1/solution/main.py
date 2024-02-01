class Node:
    def __init__(self, val=0, right=None, left=None):
        self.val = val
        self.right = right
        self.left = left


def preorder_traversal(root, level=0, prefix="Root: "):
    """
    This is for printing the tree to the console with good view
    :param root:
    :param level:
    :param prefix:
    :return: None
    """
    if root is not None:
        print(" " * (level * 4) + prefix + str(root.val))
        if root.left is not None or root.right is not None:
            preorder_traversal(root.left, level + 1, "L--- ")
            preorder_traversal(root.right, level + 1, "R--- ")


def create_balanced_bst(a_list):
    """
    Create BST from a list with a recursive helper function.
    :param a_list:
    :return: the root of the balanced BST
    """
    a_list = sorted(a_list)
    return create_balanced_bst_helper(a_list)


def create_balanced_bst_helper(a_list):
    if not a_list:
        return
    mid_idx = int(len(a_list) / 2)  # To obtain the middle element and cut the list from the middle to two piece and process them recursively.
    root = Node(val=a_list[mid_idx])
    root.left = create_balanced_bst_helper(a_list[:mid_idx])
    root.right = create_balanced_bst_helper(a_list[mid_idx + 1:])
    return root


def create_bst(a_list):
    """
    Creates BST without balancing it. It is like a single line
    :param a_list:
    :return: root of the BST
    """
    if not a_list:
        return
    root = Node(val=a_list[0])
    node = root
    for i in range(1, len(a_list)):
        if a_list[i] > node.val:
            node.right = Node(val=a_list[i])
            node = node.right
        elif a_list[i] < node.val:
            node.left = Node(val=a_list[i])
            node = node.left
    return root


def inorder_traversal(root, result):
    """
    This is for getting the numbers from the tree with sorted order to a list.
    :param root:
    :param result:
    :return: None
    """
    if not root:
        return
    inorder_traversal(root.left, result)
    result.append(root.val)
    inorder_traversal(root.right, result)


def merge_bst(root1, root2):
    """
    Get the numbers from the trees and assemble them into one list and
    reconstruct the tree.
    :param root1:
    :param root2:
    :return:
    """
    result1 = []
    result2 = []
    inorder_traversal(root1, result1)
    inorder_traversal(root2, result2)
    merged = sorted(result1 + result2)
    root = create_balanced_bst(merged)
    return root


def find_kth_smallest(root, k):
    stack = []
    while True:
        while root:
            stack.append(root)
            root = root.left

        if not stack:  # empty stack
            return None

        root = stack.pop()
        k -= 1
        if k == 0:
            return root.val
        root = root.right


def balance_BST(root):
    """
    Balances an existing one line tree.
    :param root:
    :return: root of the balanced tree
    """
    result = []
    inorder_traversal(root, result)
    root = create_balanced_bst(result)
    return root


def find_elements_within_a_range(root, lower_bound, upper_bound):
    """
    Finds the values within the range by traversing the tree inorderly.
    :param root:
    :param lower_bound:
    :param upper_bound:
    :return: List of elements within the range
    """
    if lower_bound > upper_bound:
        return
    stack = []
    result = []
    while True:
        while root:
            stack.append(root)
            root = root.left

        if not stack:
            return result

        root = stack.pop()

        if lower_bound <= root.val <= upper_bound:
            result.append(root.val)

        if root.val > upper_bound:
            return result

        root = root.right


liste1 = [1, 5, 2, 3, 7, 4, 6]
liste2 = [10, 8, 11, 13, 12, 14, 9]
root1 = create_balanced_bst(liste1)
root2 = create_balanced_bst(liste2)
root = merge_bst(root1, root2)
preorder_traversal(root1)
preorder_traversal(root2)
preorder_traversal(root)
unbalanced_root = create_bst(liste1)
preorder_traversal(unbalanced_root)
unbalanced_root = balance_BST(unbalanced_root)
preorder_traversal(unbalanced_root)
print(find_elements_within_a_range(root1, 2, 7))
