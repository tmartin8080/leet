defmodule AddTwoNumbersTest do
  use ExUnit.Case

  import AddTwoNumbers, only: [calc: 2]

  test ".calc/2" do
    assert calc([1], [2]) == [3]
    assert calc([5], [5]) == [0,1]
    assert calc([2,4,3], [5,6,4]) == [7,0,8]                     # 342 + 465 = 807
    assert calc([0,0,1], [1,1]) == [1,1,1]                       # 100 + 11 = 111
    assert calc([9,9,9,9,9,9,9], [9,9,9,9]) == [8,9,9,9,0,0,0,1] # 9,999,999 + 9,999 = 10,009,998
  end
end
