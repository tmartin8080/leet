defmodule AddTwoNumbersTest do
  use ExUnit.Case
  import AddTwoNumbers

  test "adds 3-digit lists" do
    l1 = [2, 4, 3]
    l2 = [5, 6, 4]
    assert add_two_numbers(l1, l2) == [7, 0, 8]
  end

  test "adds zero lists" do
    assert add_two_numbers([0], [0]) == [0]
  end

  test "adds 9s lists" do
    l1 = [9, 9, 9, 9, 9, 9, 9]
    l2 = [9, 9, 9, 9]
    assert add_two_numbers(l1, l2) == [8, 9, 9, 9, 0, 0, 0, 1]
  end
end
