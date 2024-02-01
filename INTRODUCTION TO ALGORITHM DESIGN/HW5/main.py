import math


################### PROBLEM 1 ###################

# Function to calculate the Euclidean distance between two drones
def drone_distance(drone1, drone2):
    return math.sqrt((drone1[0] - drone2[0]) ** 2 + (drone1[1] - drone2[1]) ** 2)


# Brute force method to calculate the smallest distance for a small set of drones
def minimum_distance_brute_force(drones):
    min_distance = float('inf')
    num_drones = len(drones)
    for i in range(num_drones):
        for j in range(i + 1, num_drones):
            min_distance = min(min_distance, drone_distance(drones[i], drones[j]))
    return min_distance


# Function to find the smallest distance between drones in a narrow strip
def closest_in_strip(strip, min_dist):
    closest_distance = min_dist
    for i in range(len(strip) - 1):
        for j in range(i + 1, min(i + 7, len(strip))):
            distance_in_strip = drone_distance(strip[i], strip[j])
            if distance_in_strip < closest_distance:
                closest_distance = distance_in_strip
    return closest_distance


# Recursive function to find the smallest distance among the drones
def closest_drone_pair_recursive(sorted_drones_x, sorted_drones_y):
    if len(sorted_drones_x) <= 3:
        return minimum_distance_brute_force(sorted_drones_x)

    mid_index = len(sorted_drones_x) // 2
    median_drone = sorted_drones_x[mid_index]

    left_drones_y = [drone for drone in sorted_drones_y if drone[0] <= median_drone[0]]
    right_drones_y = [drone for drone in sorted_drones_y if drone[0] > median_drone[0]]

    distance_left = closest_drone_pair_recursive(sorted_drones_x[:mid_index], left_drones_y)
    distance_right = closest_drone_pair_recursive(sorted_drones_x[mid_index:], right_drones_y)

    current_min_distance = min(distance_left, distance_right)

    strip = [drone for drone in sorted_drones_y if abs(drone[0] - median_drone[0]) < current_min_distance]

    return min(current_min_distance, closest_in_strip(strip, current_min_distance))


# Main function to calculate the closest pair of drones
def closest_drone_pair(drones):
    # sort them according to the x and according to the y seperately because we will need them
    # when we're dividing and when we evaluate the strip case
    # making the sorting in the beginning is necessary. we don't want to sort them in recursive case.
    sorted_drones_x = sorted(drones, key=lambda x: x[0])
    sorted_drones_y = sorted(drones, key=lambda x: x[1])
    return closest_drone_pair_recursive(sorted_drones_x, sorted_drones_y)


# Example usage
drones = [(2, 3), (12, 30), (40, 50), (5, 1), (12, 10), (3, 4)]
print("The smallest distance between any two drones is", closest_drone_pair(drones))


########################## PROBLEM 2 ################################

def find_best_perimeter(sensors):
    def cross(o, a, b):
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])

    # Find the leftmost and the rightmost points
    leftmost = min(sensors, key=lambda p: p[0])
    rightmost = max(sensors, key=lambda p: p[0])

    def build_hull(sensors, leftmost, rightmost):
        if not sensors:
            return []
        # Find the farthest point from the line [leftmost, rightmost]
        farthest = max(sensors, key=lambda p: cross(leftmost, rightmost, p))
        # Split the sensors into two groups based on which side of the line they are
        left_of_line = [p for p in sensors if cross(leftmost, farthest, p) > 0]
        right_of_line = [p for p in sensors if cross(farthest, rightmost, p) > 0]

        return build_hull(left_of_line, leftmost, farthest) + [farthest] + build_hull(right_of_line, farthest,
                                                                                      rightmost)

    left_part = [p for p in sensors if cross(leftmost, rightmost, p) > 0]
    right_part = [p for p in sensors if cross(rightmost, leftmost, p) > 0]

    return [leftmost] + build_hull(left_part, leftmost, rightmost) + [rightmost] + build_hull(right_part, rightmost,
                                                                                              leftmost)


# Example usage
sensors = [(1, 2), (3, 4), (5, 6), (7, 8), (9, 0)]
best = find_best_perimeter(sensors)
print("Sensors forming the secure perimeter:", best)


########## PROBLEM 3 ##############

def align_dna_sequences(seq1, seq2):
    n1 = len(seq1) + 1
    n2 = len(seq2) + 1
    matrix = [[0 for _ in range(n2)] for _ in range(n1)]

    # base cases
    for j in range(n2):
        matrix[0][j] = j
    for i in range(n1):
        matrix[i][0] = i

    # build table
    for i in range(1, n1):
        for j in range(1, n2):
            if seq1[i - 1] == seq2[j - 1]:
                matrix[i][j] = matrix[i - 1][j - 1]
            else:
                matrix[i][j] = min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + 3)

    return matrix[n1 - 1][n2 - 1]  # return the result


# test cases
test1 = align_dna_sequences("AGCT", "AGCT")
test2 = align_dna_sequences("AGCT", "AGGT")
test3 = align_dna_sequences("AGT", "AGCT")
test4 = align_dna_sequences("AGCT", "TCGA")

print(test1)
print(test2)
print(test3)
print(test4)


########## PROBLEM 4 ##############
def calc_discount(stores):
    pass


class Store:
    def __init__(self, name, discount):
        self.name = name
        self.discount = discount
        self.included = False


def generate_combinations(all_stores, current_index, dp, best_combinations):
    if current_index == len(all_stores):
        discount = calc_discount(all_stores)
        combination_key = tuple(store.included for store in all_stores)
        dp[combination_key] = discount
        best_combinations[discount] = [store.name for store in all_stores if store.included]
        return

    # Exclude the current store
    all_stores[current_index].included = False
    generate_combinations(all_stores, current_index + 1, dp, best_combinations)

    # Include the current store
    all_stores[current_index].included = True
    generate_combinations(all_stores, current_index + 1, dp, best_combinations)


def max_discount_dp(all_stores):
    dp = {}  # Maps a combination of stores (as a tuple of booleans) to its discount
    best_combinations = {}  # Maps discount values to the combination of stores

    generate_combinations(all_stores, 0, dp, best_combinations)

    max_discount = max(best_combinations.keys())
    best_combination = best_combinations[max_discount]

    return best_combination, max_discount




##### PROBLEM 5 #########

def max_antenna(antennas):
    """
    antennas has start_place and end_place.
    we will sort the antennas according to their end_places.
    and search all the feasible antennas.
    :param antennas: all the antennas
    :return: the max number of feasible antennas
    """
    feasible_antennas = []
    # sort the antennas according to end_place
    antennas.sort(key=lambda x: x[1])

    first_antenna = antennas[0]
    end_place = first_antenna[1]

    feasible_antennas.append(first_antenna)

    for i in range(1, len(antennas)):
        if antennas[i][0] >= end_place:  # if the start_place of the antenna is bigger or equal to the end_place of
            # the previous feasible antenna
            end_place = antennas[i][1]  # update the new end_place
            feasible_antennas.append((antennas[i]))

    return feasible_antennas


print(max_antenna([(1, 2), (3, 4), (5, 6)]))
print(max_antenna([(1, 4), (2, 5), (6, 8)]))
print(max_antenna([(1, 3), (2, 3), (4, 5)]))
print(max_antenna([(1, 10), (2, 3), (4, 5), (6, 7)]))
