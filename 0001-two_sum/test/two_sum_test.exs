defmodule TwoSumTest do
  use ExUnit.Case
  import TwoSum

  describe "two_sum/2" do
    test "return indices [0, 1] target: 9, nums: [2, 7, 11, 15]" do
      nums = [2, 7, 11, 15]
      target = 9
      assert two_sum(nums, target) == [0, 1]
    end

    test "returns indices [1, 2], target: 6, nums: [3, 2, 4]" do
      nums = [3, 2, 4]
      target = 6
      assert two_sum(nums, target) == [1, 2]
    end

    test "returns indices [0, 1], target: 6, nums: [3, 3]" do
      nums = [3, 3]
      target = 6
      assert two_sum(nums, target) == [0, 1]
    end

    test "returns indices [0, 2], target: 6, nums: [3, 2, 3]" do
      nums = [3, 2, 3]
      target = 6
      assert two_sum(nums, target) == [0, 2]
    end
  end
end
