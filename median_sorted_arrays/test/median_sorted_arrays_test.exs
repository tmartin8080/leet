defmodule MedianSortedArraysTest do
  use ExUnit.Case
  import MedianSortedArrays

  describe "find_median_sorted_arrays/2" do
    test "general cases" do
      assert find_median_sorted_arrays([1, 3], [2]) == 2
      assert find_median_sorted_arrays([1, 2], [3, 4]) == 2.5
      assert find_median_sorted_arrays([2], []) == 2
    end

    test "one empty list case" do
      assert find_median_sorted_arrays([2], []) == 2
    end
  end

  test "any number is less than infinity" do
    assert 2 < :infinity
  end

  test "any number is greater than neg infinity" do
    assert -2 > :math.pow(10, 6) * -1
  end

  test "sup with these numberss" do
    assert find_median_sorted_arrays([100_001], [100_000]) == 100_000.5
  end

  test "another fun one" do
    assert find_median_sorted_arrays([], [2, 3]) == 2.5
  end
end
