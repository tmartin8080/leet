defmodule MedianSortedArrays do
  @moduledoc """
  Binary Search to parition arrays on left | right where all values on
  left are < all values on the right.

  # Notes
  - When the size of merged inputs is even, take the median of the 2 center values.
  - When the size of merged inputs is odd, take the middle value.
  - If there are no values to compare, use -Infinity on left, and Infinity on right.

  More details on solution: https://www.youtube.com/watch?v=LPFhl65R7ww
  """

  @negative_infinity :math.pow(10, 6) * -1
  @positive_infinity :math.pow(10, 6)

  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
    {{nums1, x}, {nums2, y}} = order_arrays_by_size(nums1, nums2)

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

  # reverse inputs if x > y
  defp order_arrays_by_size(nums1, nums2) when length(nums1) > length(nums2) do
    {{nums2, Enum.count(nums2)}, {nums1, Enum.count(nums1)}}
  end

  defp order_arrays_by_size(nums1, nums2) do
    {{nums1, Enum.count(nums1)}, {nums2, Enum.count(nums2)}}
  end
end
