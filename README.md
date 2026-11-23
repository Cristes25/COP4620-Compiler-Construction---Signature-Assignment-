# COP4620 Compiler Construction – Signature Assignment

`myMap` implemented in **Java**, **Python**, and **Haskell**. Each version takes
(1) a list of integers and (2) a function `Int -> Int`, applies the function to
every element, and returns a **new** list with the results. The original list is
never modified.

```
.
├── java/       # Java implementation   (teammate)
├── python/     # Python implementation
│   ├── my_map.py        # myMap + demo program
│   └── test_my_map.py   # unit tests
└── haskell/    # Haskell implementation (teammate)
```

---

## Shared cross-language test cases

All three programs run **the same inputs and operations** so their outputs can
be compared side by side. Please print these lines in this order:

| Label              | Input list        | Operation     | Expected output        |
|--------------------|-------------------|---------------|------------------------|
| `square`           | `[1, 2, 3, 4, 5]` | `x * x`       | `[1, 4, 9, 16, 25]`    |
| `double`           | `[1, 2, 3, 4, 5]` | `x * 2`       | `[2, 4, 6, 8, 10]`     |
| `addTen`           | `[1, 2, 3, 4, 5]` | `x + 10`      | `[11, 12, 13, 14, 15]` |
| `lambda x -> x-1`  | `[1, 2, 3, 4, 5]` | `x - 1`       | `[0, 1, 2, 3, 4]`      |
| `negatives square` | `[-3, -2, -1, 0]` | `x * x`       | `[9, 4, 1, 0]`         |
| `empty list`       | `[]`              | `x * x`       | `[]`                   |
| `Original after`   | `[1, 2, 3, 4, 5]` | (none)        | `[1, 2, 3, 4, 5]` (unchanged) |

**Formatting note:** Python and Java (`List.toString()`) both print lists as
`[1, 4, 9]`. Haskell's `show` prints `[1,4,9]` with no spaces. The values are
the same; only the spacing differs. The Haskell version can use
`intercalate ", "` to match exactly.

---

## Python

### Requirements
- Python 3.8 or newer (tested with Python 3.13). No external packages.

### Run
```bash
cd python
python3 my_map.py
```

Expected output:
```
Input:            [1, 2, 3, 4, 5]
square:           [1, 4, 9, 16, 25]
double:           [2, 4, 6, 8, 10]
addTen:           [11, 12, 13, 14, 15]
lambda x -> x-1:  [0, 1, 2, 3, 4]
negatives square: [9, 4, 1, 0]
empty list:       []
Original after:   [1, 2, 3, 4, 5]
```

### Test
```bash
cd python
python3 -m unittest test_my_map.py -v
```

### Implementation
```python
def myMap(values: List[int], func: Callable[[int], int]) -> List[int]:
    if not callable(func):
        raise TypeError("myMap expects a function as its second argument")
    return [func(x) for x in values]
```

- Uses its own list comprehension rather than the built-in `map()`.
- Builds and returns a new list, so the input list is never mutated (verified by
  the `Original after` line and a unit test).
- Type hints document the `List[int]` and `Int -> Int` signature.

### Paradigm: interpreted scripting language with higher-order functions
Python is a dynamically typed, interpreted, multi-paradigm scripting language.
Functions are **first-class objects**: they can be stored in variables, passed
as arguments and created inline with `lambda`. That is what makes `myMap` a
**higher-order function**: it receives `func` as an ordinary value and calls it
on each element. The list comprehension is a declarative, functional-style
construct borrowed from languages like Haskell, so the code describes *what*
the new list contains instead of managing indexes and appends by hand. Because
Python is dynamically typed, the `Int -> Int` contract is expressed through
type hints (checked by tools like `mypy`) and a runtime `callable()` check,
not enforced by a compiler.

---

## Java

### Requirements
- Java 8 or newer (JDK). No external libraries.

### Run
cd java
javac MyMap.java MyMapTest.java
java MyMap        # demo program
java MyMapTest    # tests

### Paradigm: imperative + functional interface
Java is an imperative, object-oriented, statically typed language. Since Java 8
it supports functional style through functional interfaces and lambdas.
`myMap` takes an `IntUnaryOperator` (an `int -> int` function) as a parameter,
which makes it a higher-order function. Inside, it uses an imperative `for`
loop to build and return a new `ArrayList`, so the original list is never
modified. The type system enforces the `Int -> Int` contract at compile time.

---

## Haskell

_To be added by teammate: run instructions and paradigm explanation
(pure functional, type signature `(Int -> Int) -> [Int] -> [Int]`,
recursion with pattern matching or a fold)._
