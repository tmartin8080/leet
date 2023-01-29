defmodule MedianSortedArrays do
  @moduledoc """
  """

  @negative_infinity :math.pow(10, 6) * -1
  @positive_infinity :math.pow(10, 6)

  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
    x = Enum.count(nums1)
    y = Enum.count(nums2)

    # reverse inputs if x > y
    if x > y do
      find_median_sorted_arrays(nums2, nums1)
    end

    low = 0
    high = y

    find_median(low, high, {nums1, x}, {nums2, y})
  end

  defp find_median(low, high, {nums1, x}, {nums2, y}) do
    partition_x = round((low + high) / 2)
    partition_y = round((x + y) / 2 - partition_x)

    x_max_left =
      if partition_x == 0, do: @negative_infinity, else: Enum.at(nums1, partition_x - 1)

    x_min_right = if partition_x == x, do: @positive_infinity, else: Enum.at(nums1, partition_x)

    y_max_left =
      if partition_y == 0, do: @negative_infinity, else: Enum.at(nums2, partition_y - 1)

    y_min_right = if partition_y == y, do: @positive_infinity, else: Enum.at(nums2, partition_y)

    dbg()

    cond do
      x_max_left <= y_min_right and y_max_left <= x_min_right ->
        if Integer.mod(x + y, 2) == 0 do
          (max(x_max_left, y_max_left) + min(x_min_right, y_min_right)) / 2
        else
          max(x_max_left, y_max_left)
        end

      x_max_left > y_min_right ->
        new_high = partition_x - 1
        find_median(low, new_high, {nums1, x}, {nums2, y})

      true ->
        new_low = partition_x + 1
        find_median(new_low, high, {nums1, x}, {nums2, y})
    end
  end
end
