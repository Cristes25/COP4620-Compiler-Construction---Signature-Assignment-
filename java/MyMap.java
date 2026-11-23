import java.util.ArrayList;
import java.util.List;
import java.util.function.IntUnaryOperator;

public class MyMap {

    // Applies func to every element and returns a NEW list.
    public static List<Integer> myMap(List<Integer> values, IntUnaryOperator func) {
        if (values == null || func == null) {
            throw new IllegalArgumentException("values and func must not be null");
        }
        List<Integer> result = new ArrayList<>();
        for (int x : values) {
            result.add(func.applyAsInt(x));
        }
        return result;
    }

    static int square(int x) { return x * x; }
    static int doubleIt(int x) { return x * 2; }
    static int addTen(int x) { return x + 10; }

    public static void main(String[] args) {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5);

        System.out.println("Input:            " + numbers);
        System.out.println("square:           " + myMap(numbers, MyMap::square));
        System.out.println("double:           " + myMap(numbers, MyMap::doubleIt));
        System.out.println("addTen:           " + myMap(numbers, MyMap::addTen));
        System.out.println("lambda x -> x-1:  " + myMap(numbers, x -> x - 1));
        System.out.println("negatives square: " + myMap(List.of(-3, -2, -1, 0), MyMap::square));
        System.out.println("empty list:       " + myMap(List.of(), MyMap::square));
        System.out.println("Original after:   " + numbers);
    }
}