# COP4620 Compiler Construction – Signature Assignment

`myMap` implemented in **Java**, **Python**, and **Haskell**. Each version takes
(1) a list of integers and (2) a function `Int -> Int`, applies the function to
every element, and returns a **new** list with the results. The original list is
never modified.

```
.
├── java/       # Java implementation   
├── python/     # Python implementation
│   ├── my_map.py        # myMap + demo program
│   └── test_my_map.py   # unit tests
└── haskell/    # Haskell implementation
    ├── MyMap.hs         # myMap + demo program
    └── MyMapTest.hs     # unit tests
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

### Requirements
- GHC (Glasgow Haskell Compiler) and `runghc` (tested with GHC 9.x / 8.x in Ubuntu WSL). No external packages required.

### Run
Interpreted mode (fastest, no build artifacts):
```bash
cd haskell
runghc MyMap.hs
```

Or compiled to a native binary:
```bash
cd haskell
ghc -o MyMap MyMap.hs
./MyMap
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
Interpreted mode:
```bash
cd haskell
runghc -i. MyMapTest.hs
```

Or compiled to a native binary:
```bash
cd haskell
ghc -i. -o MyMapTest MyMapTest.hs
./MyMapTest
```

### Implementation
```haskell
myMap :: (Int -> Int) -> [Int] -> [Int]
myMap _    []     = []
myMap func (x:xs) = func x : myMap func xs
```

- Implemented using **pattern matching** and **explicit structural recursion** over lists.
- **Base case**: `myMap _ [] = []` handles the empty list.
- **Recursive case**: `myMap func (x:xs) = func x : myMap func xs` applies `func` to the head element `x` and recursively processes the tail `xs`, prepending results with the cons operator (`:`).
- Custom formatting function `formatList` uses `intercalate ", "` to match the exact string output of Java's `List.toString()` and Python's `format_list`.

### Paradigm: pure functional programming with immutability and pattern matching
Haskell is a purely functional, statically typed, and lazy language.
- **Pure Functions & Immutability**: Values in Haskell are strictly immutable. There is no concept of in-place mutation or side effects; `myMap` produces a brand-new list without altering the original list.
- **First-Class & Higher-Order Functions**: Functions are first-class values that can be passed as arguments, returned, or created inline with anonymous lambdas (`\x -> x - 1`). `myMap` takes another function as its first argument, adhering to the type signature `(Int -> Int) -> [Int] -> [Int]`.
- **Declarative Recursion & Pattern Matching**: Instead of imperative stateful loops (`for`/`while`) or index management, Haskell expresses algorithms through pattern matching on data constructors (`[]` and `(:)`).
- **Compile-Time Type Safety**: Haskell's strong static type system enforces the function contract at compile time, guaranteeing that only functions compatible with `Int -> Int` and lists of type `[Int]` are accepted.

---

## Build Artifacts & Git Configuration (.gitignore)

To maintain a clean repository and ensure that only source code is tracked in GitHub, `.gitignore` was updated with the following rationale:

1. **Platform-Independent Source Control**: Compiling code in Haskell (`ghc`) generates machine-specific binary executables (`haskell/MyMap` and `haskell/MyMapTest` without file extensions in Linux/WSL, or `.exe` on Windows). Binary executables are large, non-portable between operating systems, and should never be stored in Git.
2. **Intermediate Compiler Outputs**: GHC produces interface files (`*.hi`, `*.dyn_hi`) and object files (`*.o`, `*.dyn_o`) during compilation. Ignoring these ensures working directories remain clutter-free.
3. **Cross-Language Isolation**: The exclusion rules for executables are explicitly scoped (e.g., `haskell/MyMap`), ensuring that existing and future source files across Java (`.java`), Python (`.py`), and Haskell (`.hs`) are safely tracked without conflicts.
