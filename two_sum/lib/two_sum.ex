defmodule TwoSum do
  @moduledoc """
  ## Approach
  Loop over input values storing indices and seen values until a value equal
  to the difference between the target input and the current value is found.

  When the difference is found, return the indices of the current value and the difference value.

  Time Complexity: `O(N)`
  """
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    nums
    |> Enum.reduce_while({%{}, 0}, fn num, {acc, index} ->
      diff = target - num

      if Map.has_key?(acc, diff) do
        {:halt, [Map.get(acc, diff), index]}
      else
        acc = Map.put(acc, num, index)
        {:cont, {acc, index + 1}}
      end
    end)
  end
end
