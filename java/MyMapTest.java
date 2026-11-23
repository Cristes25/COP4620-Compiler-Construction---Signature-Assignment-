import java.util.List;

public class MyMapTest {
    private static int failures = 0;

    private static void check(String name, Object expected, Object actual) {
        if (expected.equals(actual)) {
            System.out.println("PASS: " + name);
        } else {
            failures++;
            System.out.println("FAIL: " + name + " expected " + expected + " but got " + actual);
        }
    }

    public static void main(String[] args) {
        List<Integer> nums = List.of(1, 2, 3, 4, 5);

        check("square", List.of(1, 4, 9, 16, 25), MyMap.myMap(nums, x -> x * x));
        check("double", List.of(2, 4, 6, 8, 10), MyMap.myMap(nums, x -> x * 2));
        check("addTen", List.of(11, 12, 13, 14, 15), MyMap.myMap(nums, x -> x + 10));
        check("lambda x-1", List.of(0, 1, 2, 3, 4), MyMap.myMap(nums, x -> x - 1));
        check("negatives", List.of(9, 4, 1, 0), MyMap.myMap(List.of(-3, -2, -1, 0), x -> x * x));
        check("empty list", List.of(), MyMap.myMap(List.of(), x -> x * x));
        check("original unchanged", List.of(1, 2, 3, 4, 5), nums);
        check("returns new list", false, MyMap.myMap(nums, x -> x) == nums);

        try {
            MyMap.myMap(nums, null);
            check("null function throws", true, false);
        } catch (IllegalArgumentException e) {
            check("null function throws", true, true);
        }

        System.out.println(failures == 0 ? "All tests passed." : failures + " test(s) failed.");
    }
}