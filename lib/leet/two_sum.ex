defmodule Leet.TwoSum do
  def two_sum(nums, target) do
    nums
    |> Enum.with_index()
    |> Enum.reduce_while([], fn {num, index}, acc ->
      find_value = target - num

      case Enum.find_index(nums, &(&1 == find_value)) do
        nil -> {:cont, acc}
        match_index when match_index != index -> {:halt, Enum.sort([index, match_index])}
        _other -> {:cont, acc}
      end
    end)
  end
end
