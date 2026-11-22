"""
COP4620 Compiler Construction - Signature Assignment
Python implementation of myMap.

myMap takes (1) a list of integers and (2) a function Int -> Int, applies the
function to every element, and returns a NEW list with the results. The
original list is never modified.

Run:   python3 my_map.py
"""

from typing import Callable, List

IntFunction = Callable[[int], int]


def myMap(values: List[int], func: IntFunction) -> List[int]:
    """Return a new list containing func(x) for every x in values.

    Implemented with a list comprehension (custom logic, not the built-in
    map()). The comprehension builds a brand-new list, so `values` is left
    untouched (no side effects).
    """
    if not callable(func):
        raise TypeError("myMap expects a function as its second argument")
    return [func(x) for x in values]


# --- Math operations used in the shared cross-language test cases ----------

def square(x: int) -> int:
    return x * x


def double(x: int) -> int:
    return x * 2


def add_ten(x: int) -> int:
    return x + 10


def format_list(values: List[int]) -> str:
    """Format a list as "[a, b, c]" so output matches Java's List.toString()."""
    return "[" + ", ".join(str(v) for v in values) + "]"


def main() -> None:
    # Shared test cases: the Java and Haskell versions use the same inputs
    # and operations, so all three programs print the same results.
    numbers = [1, 2, 3, 4, 5]

    print("Input:            " + format_list(numbers))
    print("square:           " + format_list(myMap(numbers, square)))
    print("double:           " + format_list(myMap(numbers, double)))
    print("addTen:           " + format_list(myMap(numbers, add_ten)))
    # Python's higher-order support also lets us pass an anonymous function.
    print("lambda x -> x-1:  " + format_list(myMap(numbers, lambda x: x - 1)))
    print("negatives square: " + format_list(myMap([-3, -2, -1, 0], square)))
    print("empty list:       " + format_list(myMap([], square)))
    print("Original after:   " + format_list(numbers))


if __name__ == "__main__":
    main()
