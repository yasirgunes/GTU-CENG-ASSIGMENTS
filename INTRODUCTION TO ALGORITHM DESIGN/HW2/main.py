class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def sorted_list_to_bst(nums):
    if not nums:
        return None

    mid = len(nums) // 2

    node = TreeNode(nums[mid])
    node.left = sorted_list_to_bst(nums[:mid])
    node.right = sorted_list_to_bst(nums[mid + 1:])

    return node

def height_of_tree(node):
    if node is None:
        return 0
    else:
        left_height = height_of_tree(node.left)
        right_height = height_of_tree(node.right)
        return max(left_height, right_height) + 1


def is_balanced(node):
    # base case
    if node is None:
        return True

    left_height = height_of_tree(node.left)
    right_height = height_of_tree(node.right)

    if abs(left_height - right_height) > 1:
        return False

    return is_balanced(node.left) and is_balanced(node.right)

def print_tree(node, level=0):
    if node is None:
        return

    print_tree(node.right, level + 1)
    print('    ' * level + str(node.val))
    print_tree(node.left, level + 1)


# Test the function
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9]
root = sorted_list_to_bst(nums)
balanced = is_balanced(root)

print_tree(root)
print(balanced)
