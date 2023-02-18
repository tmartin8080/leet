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
    {{nums1, m}, {nums2, n}} = shortest_first(nums1, nums2)
    range = {0, m}
    find_median(range, {nums1, m}, {nums2, n})
  end

  defp find_median({low, high}, {nums1, m}, {nums2, n}) do
    {partition_m, partition_n} = partition_arrays({low, high}, m, n)

    m_max_left =
      if partition_m == 0, do: @negative_infinity, else: :array.get(partition_m - 1, nums1)

    m_min_right =
      if partition_m == m, do: @positive_infinity, else: :array.get(partition_m, nums1)

    n_max_left =
      if partition_n == 0, do: @negative_infinity, else: :array.get(partition_n - 1, nums2)

    n_min_right =
      if partition_n == n, do: @positive_infinity, else: :array.get(partition_n, nums2)

    cond do
      m_max_left <= n_min_right and n_max_left <= m_min_right ->
        if Integer.mod(m + n, 2) == 0 do
          (max(n_max_left, m_max_left) + min(m_min_right, n_min_right)) / 2
        else
          max(m_max_left, n_max_left)
        end

      m_max_left > n_min_right ->
        new_high = partition_m - 1
        find_median({low, new_high}, {nums1, m}, {nums2, n})

      true ->
        new_low = partition_m + 1
        find_median({new_low, high}, {nums1, m}, {nums2, n})
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
