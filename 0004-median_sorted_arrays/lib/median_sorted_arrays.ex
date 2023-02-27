defmodule MedianSortedArrays do
  @moduledoc """
  ## Approach

  1. Start with the shortest array
  2. Partition arrays on `left` | `right` so all values on left are < all values on the right.
    - If there are no values to compare, use -Infinity on left, and +Infinity on right.
    - Shift partitioning left, right until true.
  3. Median - Odd vs Even
    - When the size of combined arrays is even, take the max of left values.
    - When the size of combined arrays is odd, take the average of max_left + max_right values.


  ## Time Complexity

  `O(log(m+n))`

  ## Benchmarks

  ```
  mix run bench.exs
  ```
  """

  @neginf :math.pow(10, 6) * -1
  @posinf :math.pow(10, 6)

  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
    {{a1, m}, {a2, n}} = shortest_first(nums1, nums2)
    range = {0, max(m, 0)}
    find_median(range, {a1, m}, {a2, n})
  end

  defp find_median({low, high}, {a1, m}, {a2, n}) do
    {a1_partition, a2_partition} = partition_arrays({low, high}, m, n)

    a1_max_left = if a1_partition == 0, do: @neginf, else: :array.get(a1_partition - 1, a1)
    a1_min_right = if a1_partition == m, do: @posinf, else: :array.get(a1_partition, a1)
    a2_max_left = if a2_partition == 0, do: @neginf, else: :array.get(a2_partition - 1, a2)
    a2_min_right = if a2_partition == n, do: @posinf, else: :array.get(a2_partition, a2)

    cond do
      a1_max_left <= a2_min_right and a2_max_left <= a1_min_right ->
        max_left = max(a1_max_left, a2_max_left)
        min_right = min(a1_min_right, a2_min_right)

        if Integer.mod(m + n, 2) == 0 do
          (max_left + min_right) / 2
        else
          max_left
        end

      a1_max_left > a2_min_right ->
        new_high = a1_partition - 1
        find_median({low, new_high}, {a1, m}, {a2, n})

      true ->
        new_low = a1_partition + 1
        find_median({new_low, high}, {a1, m}, {a2, n})
    end
  end

  # convert to actual arrays and sort by ascending length
  defp shortest_first(nums1, nums2) do
    a1 = :array.from_list(nums1)
    a2 = :array.from_list(nums2)
    a1_length = :array.size(a1)
    a2_length = :array.size(a2)

    if a1_length <= a2_length do
      {{a1, a1_length}, {a2, a2_length}}
    else
      {{a2, a2_length}, {a1, a1_length}}
    end
  end

  defp partition_arrays({low, high}, m, n) do
    a1_partition = round((low + high) / 2)
    a2_partition = round((m + n) / 2 - a1_partition)
    {max(a1_partition, 0), max(a2_partition, 0)}
  end
end
