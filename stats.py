#!/usr/bin/python
import sys
from math import sqrt

# probably more efficient:
# def calc_median(number_list: list) -> float:
#     number_list.sort()
#     middle = len(number_list) // 2
#     a = number_list[middle]
#     b = number_list[-middle-1]  # for odd lengths, a == b
#     return (a + b) / 2


def calc_median(number_list: list) -> float:
    sorted_numbers = sorted(number_list)
    middle = len(sorted_numbers) // 2  # integer division to cut off the remainder
    if len(sorted_numbers) % 2 != 0:
        return sorted_numbers[middle]
    else:
        return sum(sorted_numbers[middle-1:middle+1]) / 2


def show_statistics(numbers: list) -> None:
    mean = sum(numbers) / len(numbers)
    median = calc_median(numbers)
    variance = sum([((x - mean) ** 2) for x in numbers]) / len(numbers)
    standard_dev = sqrt(variance)
    print(f"Mean: {mean}\n"
          f"Median: {median}\n"
          f"Standard Deviation: {standard_dev}")


def parse_input_numbers(number_input: str) -> None:
    print(f"Given numbers were: {number_input}")
    number_list = [float(n.replace(',', '.')) for n in number_input.split(" ")]
    print(f"Parsed numbers are: {number_list}")
    show_statistics(number_list)


if __name__ == "__main__":
    # check if command line arguments were given, else try to read from stdin
    if len(sys.argv) > 1:
        try:
            with open(sys.argv[1], "r") as file:
                content = file.read()
                parse_input_numbers(content)
        except IOError:
            raise IOError("A file containing the numbers is needed!")
    else:
        print("Enter any number of floating point numbers separated with"
              " a space (press 'enter' to start the program):\n")
        try:
            # read until a linebreak is detected and remove the linebreak
            # from the input with 'rstrip()'
            user_input = sys.stdin.readline().rstrip()
            parse_input_numbers(user_input)
        except IOError:
            raise IOError("Please provide arguments separated with a space!")
