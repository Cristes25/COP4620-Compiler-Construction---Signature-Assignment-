"""Unit tests for the Python myMap implementation.

Run:   python3 -m unittest test_my_map.py -v
"""

import unittest

from my_map import add_ten, double, format_list, myMap, square


class TestMyMap(unittest.TestCase):
    def test_square(self):
        self.assertEqual(myMap([1, 2, 3, 4, 5], square), [1, 4, 9, 16, 25])

    def test_double(self):
        self.assertEqual(myMap([1, 2, 3, 4, 5], double), [2, 4, 6, 8, 10])

    def test_add_ten(self):
        self.assertEqual(myMap([1, 2, 3, 4, 5], add_ten), [11, 12, 13, 14, 15])

    def test_lambda(self):
        self.assertEqual(myMap([1, 2, 3], lambda x: x - 1), [0, 1, 2])

    def test_negative_numbers(self):
        self.assertEqual(myMap([-3, -2, -1, 0], square), [9, 4, 1, 0])

    def test_empty_list(self):
        self.assertEqual(myMap([], square), [])

    def test_original_list_not_modified(self):
        original = [1, 2, 3]
        result = myMap(original, double)
        self.assertEqual(original, [1, 2, 3])
        self.assertIsNot(result, original)

    def test_returns_list(self):
        self.assertIsInstance(myMap([1, 2], square), list)

    def test_rejects_non_function(self):
        with self.assertRaises(TypeError):
            myMap([1, 2, 3], 5)

    def test_format_matches_java(self):
        self.assertEqual(format_list([1, 4, 9]), "[1, 4, 9]")


if __name__ == "__main__":
    unittest.main()
