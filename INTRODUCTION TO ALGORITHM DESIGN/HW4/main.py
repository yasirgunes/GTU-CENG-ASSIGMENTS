## Question 1 ##
def find_flawed_fuse(fuses):
    begin = 0
    while begin < len(fuses):
        if is_healthy_fuse(fuses[begin]):
            begin += 1
        else:
            return begin

    return None


def is_healthy_fuse(fuse):
    if fuse == "ok":
        return True
    return False


def test_case_1():
    fuses = ["ok", "ok", "ok", "ok", "ok", "flawed", "ok"]
    index = find_flawed_fuse(fuses)
    print(f"Flawed fuse is at the index of: {index}")


test_case_1()

## Question 2

def find_distinct_brightest(grid):
    row = 0
    column = 0
    row_size = len(grid)
    column_size = len(grid[0])
    # starting from top left corner

    # check if the right and down neighbor is brighter
    right_brighter = (grid[row][column] < grid[row][column + 1])
    down_brighter = (grid[row][column] < grid[row + 1][column])
    is_edge = False

    while True:
        # for increasing case
        if (not right_brighter and not down_brighter):
            return row, column  # return row and column tuple

        if is_edge:
            row += 1
            column = 0
        else:
            column += 1

        # if it is the end of grid and the result is not found yet return None.
        is_end_of_grid = (row == row_size - 1 and column == column_size - 1)
        if is_end_of_grid:
            return None

        is_edge = column == column_size - 1  # if is_edge we're at the edge of the grid
        # check if the right and down neighbor is brighter

        # if the last column right_brighter is not necessary
        if not (column == column_size - 1):
            right_brighter = (grid[row][column] < grid[row][column + 1])
        else:
            right_brighter = False

        # if the last row down_brighter is not necessary
        if not (row == row_size - 1):
            down_brighter = (grid[row][column] < grid[row + 1][column])
        else:
            down_brighter = False





def test_case_2():
    grid1 = [
        [1, 2, 3, 4, 5],
        [2, 3, 4, 5, 6],
        [3, 4, 100, 6, 7],
        [4, 5, 6, 7, 8],
        [5, 6, 7, 8, 9]
    ]
    # Expected output: (2, 2) - The brightest pixel is at row 2, column 2
    grid2 = [
        [1, 2, 3, 4, 50],
        [2, 3, 4, 5, 6],
        [3, 4, 5, 6, 7],
        [4, 5, 6, 7, 8],
        [5, 6, 7, 8, 9]
    ]
    # Expected output: (0, 4) - The brightest pixel is at row 0, column 4


    result1 = find_distinct_brightest(grid1)
    result2 = find_distinct_brightest(grid2)

    print(result1)
    print(result2)



test_case_2()


# Question 3
def find_consecutive_subsets(input_list):
    subsets = []
    n = len(input_list)

    # Iterate over all possible starting points
    for i in range(n):
        # Create subsets of increasing lengths
        for j in range(i, n):
            subsets.append(input_list[i:j+1])

    return subsets

def total_area_under_curve(f_values):
    return sum(f_values)

def max_area(f_values):
    subsets = find_consecutive_subsets(f_values)
    max_area = float('-inf')

    for subset in subsets:
        area = total_area_under_curve(subset)
        if area > max_area:
            max_area = area

    return max_area

# Example usage
f_values = [2, -3, 4, -1, 3, -2]  # Example values of f(x)
area = max_area(f_values)
print("Max area:", area)



# Question 4
def find_paths(graph, start, end, path=[]):
    path = path + [start]
    if start == end:
        return [path]
    if start not in graph:
        return []
    paths = []
    for node in graph[start]:
        if node not in path:
            newpaths = find_paths(graph, node, end, path)
            for newpath in newpaths:
                paths.append(newpath)
    return paths

def calculate_latency(path, latencies):
    total_latency = 0
    for i in range(len(path)-1):
        total_latency += latencies[(path[i], path[i+1])]
    return total_latency

def find_min_latency_path(graph, latencies, start, end):
    paths = find_paths(graph, start, end)
    min_latency = float('inf')
    min_latency_path = None
    for path in paths:
        latency = calculate_latency(path, latencies)
        if latency < min_latency:
            min_latency = latency
            min_latency_path = path
    return min_latency_path, min_latency

# Example graph and latencies
graph = {'A': ['B', 'C'], 'B': ['C', 'D'], 'C': ['D'], 'D': ['C'], 'E': ['F'], 'F': ['C']}
latencies = {('A', 'B'): 2, ('A', 'C'): 3, ('B', 'C'): 4, ('B', 'D'): 5, ('C', 'D'): 1, ('D', 'C'): 3, ('E', 'F'): 2, ('F', 'C'): 4}
start, end = 'A', 'D'

# Find path with minimum latency
min_latency_path, min_latency = find_min_latency_path(graph, latencies, start, end)
print(f"Path with minimum latency: {min_latency_path}, Total latency: {min_latency}")



# Question 5
def compare_max(task1, task2):
    if task1[1] > task2[1]:
        return task1
    return task2

def compare_min(task1, task2):
    if task1[1] < task2[1]:
        return task1
    return task2

def allocate_resources(tasks):
    if len(tasks) == 1:
        return tasks[0], tasks[0]  # base case: return the task as both max and min

    mid = len(tasks) // 2
    left_max, left_min = allocate_resources(tasks[:mid])
    right_max, right_min = allocate_resources(tasks[mid:])

    return compare_max(left_max, right_max), compare_min(left_min, right_min)

# Example usage
tasks = [(1, 20), (2, 15), (3, 30), (4, 10)]
max_task, min_task = allocate_resources(tasks)
print("Max Task:", max_task)
print("Min Task:", min_task)

