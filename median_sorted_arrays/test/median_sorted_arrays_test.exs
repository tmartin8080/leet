defmodule MedianSortedArraysTest do
  use ExUnit.Case
  import MedianSortedArrays

  test "find_median_sorted_arrays/2" do
    assert find_median_sorted_arrays([1, 3], [2]) == 2
    assert find_median_sorted_arrays([1, 2], [3, 4]) == 2.5
  end

  test "any number is less than infinity" do
    assert 2 < :infinity
  end

  test "any number is greater than neg infinity" do
    assert -2 > :math.pow(10, 6) * -1
  end
end
