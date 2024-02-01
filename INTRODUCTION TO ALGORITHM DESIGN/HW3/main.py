def max_discount(set_of_stores, index=0, current_list=None):
    if current_list is None:
        current_list = []

    if index == len(set_of_stores):
        return calc_discount(current_list)

    # Include the current store
    include = max_discount(set_of_stores, index + 1, current_list + [set_of_stores[index]])

    # Exclude the current store
    exclude = max_discount(set_of_stores, index + 1, current_list)

    return max(include, exclude)


# n processes n users n processors

def optimal_job_schedule(user_process_pairs, processors):
    optimal_schedule = []
    min_cost = float('inf')

    # Generate all possible schedules
    total_processes = len(user_process_pairs)
    total_processors = len(processors)
    max_combinations = total_processors ** total_processes

    for i in range(max_combinations):
        current_schedule = []
        temp = i

        # Assign each process to a processor
        for j in range(total_processes):
            processor_index = temp % total_processors
            temp //= total_processors
            current_schedule.append((user_process_pairs[j], processors[processor_index]))

        # Compute the cost for the current schedule
        current_cost = compute_total_cost(current_schedule)

        # Update the optimal schedule if the current one is better
        if current_cost < min_cost:
            min_cost = current_cost
            optimal_schedule = current_schedule.copy()

    return optimal_schedule


def get_permutations(input_list):
    if len(input_list) == 0:
        return [[]]  # Base case: an empty list has only one permutation, which is an empty list

    permutations_list = []

    for i in range(len(input_list)):
        current_element = input_list[i]
        remaining_elements = input_list[:i] + input_list[i + 1:]

        # Recursively get permutations of the remaining elements
        for perm in get_permutations(remaining_elements):
            permutations_list.append([current_element] + perm)

    return permutations_list


def find_optimal_product_sequence(parts):
    min_cost_sequence = []
    min_cost = float("inf")
    all_sequences = get_permutations(parts)

    for sequence in all_sequences:
        cost = cost_of_sequence(sequence)
        if cost < min_cost:
            min_cost = cost
            min_cost_sequence = sequence

    return min_cost_sequence


def min_coins(coins, amount):
    if amount == 0:
        return 0
    elif amount < 0:
        return float('inf')  # Infinity, indicating no valid solution

    minCount = float('inf')  # Initialize with a large value

    for coin in coins:
        if coin <= amount:
            count = 1 + min_coins(coins, amount - coin)
            if count < minCount:
                minCount = count

    return minCount

# Example usage:
coins = [1, 2, 5, 10]
target = 31
min_coin_count = min_coins(coins, target)
print(f"Minimum number of coins needed to make {target} cents: {min_coin_count}")
