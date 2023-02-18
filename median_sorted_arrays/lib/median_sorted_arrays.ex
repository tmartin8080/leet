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
    {{a1, m}, {a2, n}} = shortest_first(nums1, nums2)
    range = {0, m}
    find_median(range, {a1, m}, {a2, n})
  end

  defp find_median({low, high}, {a1, m}, {a2, n}) do
    {a1_partition, a2_partition} = partition_arrays({low, high}, m, n)

    a1_max_left =
      if a1_partition == 0, do: @negative_infinity, else: :array.get(a1_partition - 1, a1)

    a1_min_right =
      if a1_partition == m, do: @positive_infinity, else: :array.get(a1_partition, a1)

    a2_max_left =
      if a2_partition == 0, do: @negative_infinity, else: :array.get(a2_partition - 1, a2)

    a2_min_right =
      if a2_partition == n, do: @positive_infinity, else: :array.get(a2_partition, a2)

    cond do
      a1_max_left <= a2_min_right and a2_max_left <= a1_min_right ->
        if Integer.mod(m + n, 2) == 0 do
          (max(a2_max_left, a1_max_left) + min(a1_min_right, a2_min_right)) / 2
        else
          max(a1_max_left, a2_max_left)
        end

      a1_max_left > a2_min_right ->
        new_high = a2_partition - 1
        find_median({low, new_high}, {a1, m}, {a2, n})

      true ->
        new_low = a1_partition + 1
        find_median({new_low, high}, {a1, m}, {a2, n})
    end
  end

  # convert to actual arrays and sort by ascending length
  defp shortest_first(nums1, nums2) do
    nums1 = :array.from_list(nums1)
    nums2 = :array.from_list(nums2)
    nums1_length = :array.size(nums1)
    nums2_length = :array.size(nums2)

    if nums1_length <= nums2_length do
      {{nums1, nums1_length}, {nums2, nums2_length}}
    else
      {{nums2, nums2_length}, {nums1, nums1_length}}
    end
  end

  defp partition_arrays({low, high}, m, n) do
    partition_m = round((low + high) / 2)
    partition_n = round((m + n) / 2 - partition_m)
    {partition_m, partition_n}
  end
end
