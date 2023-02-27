defmodule LongestPalindromeSubstring do
  @moduledoc """
  ## Approach
  - Convert String to Map for efficient random access (vs Linked List).
  - Iterate over each char to expand_range (Expand Around Center).
  - expand_range expands while palindrome is found, returns current longest when not found.
  - expand_range is called twice, once for odd and once for even length substrings.

  ## Time Complexity

  `O(n^2)`

  ## Profiling

  ```
  mix profile.eprof -e "LongestPalindromeSubstring.longest_palindrome(\"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\")"

  ## Benchmarks

  ```
  mix run bench.exs
  ```
  """
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    {chars, n} = to_map(s)
    find_longest({s, chars, n}, 0, {0, 0})
  end

  defp find_longest({s, _chars, n}, index, {left, right}) when index > n do
    String.slice(s, left..right)
  end

  defp find_longest(data, index, longest) do
    longest = expand_range(data, index, index, longest)
    longest = expand_range(data, index, index + 1, longest)
    find_longest(data, index + 1, longest)
  end

  defp expand_range({_s, _chars, n} = data, left, right, longest) when left == right do
    new_left = max(left - 1, 0)
    new_right = min(right + 1, n)
    expand_range(data, new_left, new_right, longest)
  end

  defp expand_range({_s, chars, n} = data, left, right, longest) when left >= 0 and right <= n do
    if Map.get(chars, left) == Map.get(chars, right) do
      new_longest = update_longest({left, right}, longest)

      expand_range(data, left - 1, right + 1, new_longest)
    else
      longest
    end
  end

  defp expand_range(_data, _left, _right, longest), do: longest

  # keep first one found
  defp update_longest({a, b}, {c, d} = longest) when d - c >= b - a, do: longest
  defp update_longest(new, _longest), do: new

  defp to_map(s) do
    s
    |> String.codepoints()
    |> Enum.reduce({%{}, 0}, fn char, {map, index} ->
      new_map = Map.put(map, index, char)
      {new_map, index + 1}
    end)
  end
end
