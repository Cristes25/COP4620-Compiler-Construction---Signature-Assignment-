{- |
COP4620 Compiler Construction – Signature Assignment
Haskell implementation of myMap.

myMap takes (1) a function (Int -> Int) and (2) a list of integers,
applies the function to every element, and returns a NEW list with the
results. The original list is never modified (Haskell values are immutable).

Run (demo):   cd haskell && runghc MyMap.hs
Compile:      cd haskell && ghc -o MyMap MyMap.hs && ./MyMap
-}

module MyMap where

import Data.List (intercalate)

-- ---------------------------------------------------------------------------
-- Core: myMap
-- ---------------------------------------------------------------------------

-- | Apply @func@ to every element of @xs@ and return the new list.
--
-- Implemented with explicit recursion and pattern matching:
--   * Base case  – the empty list maps to the empty list.
--   * Recursive case – apply @func@ to the head, then recurse on the tail.
--
-- Type signature: (Int -> Int) -> [Int] -> [Int]
-- This makes myMap a higher-order function: it receives another function
-- as its first argument.
myMap :: (Int -> Int) -> [Int] -> [Int]
myMap _    []     = []
myMap func (x:xs) = func x : myMap func xs

-- ---------------------------------------------------------------------------
-- Helper functions matching Java / Python equivalents
-- ---------------------------------------------------------------------------

square :: Int -> Int
square x = x * x

double :: Int -> Int
double x = x * 2

addTen :: Int -> Int
addTen x = x + 10

-- ---------------------------------------------------------------------------
-- Formatting – produce "[a, b, c]" to match Java's List.toString() and Python
-- ---------------------------------------------------------------------------

formatList :: [Int] -> String
formatList xs = "[" ++ intercalate ", " (map show xs) ++ "]"

-- ---------------------------------------------------------------------------
-- Demo program – shared cross-language output
-- ---------------------------------------------------------------------------

main :: IO ()
main = do
    let numbers = [1, 2, 3, 4, 5]

    putStrLn $ "Input:            " ++ formatList numbers
    putStrLn $ "square:           " ++ formatList (myMap square  numbers)
    putStrLn $ "double:           " ++ formatList (myMap double  numbers)
    putStrLn $ "addTen:           " ++ formatList (myMap addTen  numbers)
    putStrLn $ "lambda x -> x-1:  " ++ formatList (myMap (\x -> x - 1) numbers)
    putStrLn $ "negatives square: " ++ formatList (myMap square  [-3, -2, -1, 0])
    putStrLn $ "empty list:       " ++ formatList (myMap square  [])
    putStrLn $ "Original after:   " ++ formatList numbers
