{- |
COP4620 Compiler Construction – Signature Assignment
Unit tests for the Haskell myMap implementation.

Mirrors the test cases in Java's MyMapTest.java and Python's test_my_map.py.

Run:   cd haskell && runghc MyMapTest.hs
-}

module Main where

import MyMap (myMap, square, double, addTen, formatList)

-- ---------------------------------------------------------------------------
-- Minimal test harness (no external packages needed)
-- ---------------------------------------------------------------------------

data Result = Pass String | Fail String String String

check :: (Eq a, Show a) => String -> a -> a -> Result
check name expected actual
    | expected == actual = Pass name
    | otherwise          = Fail name (show expected) (show actual)

printResult :: Result -> IO ()
printResult (Pass name)             = putStrLn $ "PASS: " ++ name
printResult (Fail name exp got)     = putStrLn $ "FAIL: " ++ name
                                             ++ " expected " ++ exp
                                             ++ " but got "  ++ got

countFailures :: [Result] -> Int
countFailures = length . filter isFail
  where isFail (Fail {}) = True
        isFail _          = False

-- ---------------------------------------------------------------------------
-- Test cases – match Java MyMapTest and Python test_my_map exactly
-- ---------------------------------------------------------------------------

tests :: [Result]
tests =
    [ check "square"            [1, 4, 9, 16, 25]  (myMap square  [1, 2, 3, 4, 5])
    , check "double"            [2, 4, 6, 8, 10]   (myMap double  [1, 2, 3, 4, 5])
    , check "addTen"            [11,12,13,14,15]   (myMap addTen  [1, 2, 3, 4, 5])
    , check "lambda x->x-1"     [0, 1, 2, 3, 4]    (myMap (\x -> x - 1) [1, 2, 3, 4, 5])
    , check "negatives square"  [9, 4, 1, 0]       (myMap square  [-3, -2, -1, 0])
    , check "empty list"        []                 (myMap square  [])
    , check "original unchanged" [1,2,3]           original   -- Haskell values are immutable
    , check "returns new list"  [2, 4, 6]          (myMap double  original)
    , check "single element"    [100]              (myMap square  [10])
    , check "identity function" [1,2,3,4,5]        (myMap id      [1, 2, 3, 4, 5])
    , check "formatList"        "[1, 4, 9]"        (formatList [1, 4, 9])
    ]
  where
    original = [1, 2, 3]

-- ---------------------------------------------------------------------------
-- Main
-- ---------------------------------------------------------------------------

main :: IO ()
main = do
    mapM_ printResult tests
    let failures = countFailures tests
    if failures == 0
        then putStrLn "All tests passed."
        else putStrLn $ show failures ++ " test(s) failed."
