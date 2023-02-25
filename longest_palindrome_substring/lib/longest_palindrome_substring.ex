defmodule LongestPalindromeSubstring do
  @moduledoc """
  ## Approach
  1. Set starting context
  2. Iterate over each char to expand_range (Expand Around Center)
  3. expand_range expands while palindrome is found, halts when not found
  4. called twice, once for odd and once for even substrings, overwrites context.
  5. String -> HashMap for efficent random lookup (vs Linked List)

  ## Solution Details
  https://youtu.be/DK5OKKbF6GI

  ## Profiling

  ```
  mix profile.eprof -e "LongestPalindromeSubstring.longest_palindrome(\"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\")"
  ```
  """
  require Logger
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    {array, n} = to_array(s)
    find_longest({s, array, n}, 0, {0, 0})
  end

  defp find_longest({s, _array, n}, index, {left, right}) when index > n do
    String.slice(s, left..right)
  end

  defp find_longest(data, index, longest) do
    longest = expand_range(data, index, index, longest)
    longest = expand_range(data, index, index + 1, longest)
    find_longest(data, index + 1, longest)
  end

  defp expand_range({_s, _array, n} = data, left, right, longest) when left == right do
    new_left = max(left - 1, 0)
    new_right = min(right + 1, n)
    expand_range(data, new_left, new_right, longest)
  end

  defp expand_range({_s, array, n} = data, left, right, longest) when left >= 0 and right <= n do
    if :array.get(left, array) == :array.get(right, array) do
      new_longest = update_longest({left, right}, longest)

      expand_range(data, left - 1, right + 1, new_longest)
    else
      longest
    end
  end

  defp expand_range(_data, _left, _right, longest), do: longest

  # keep first one found in case of even
  defp update_longest({a, b}, {c, d} = longest) when d - c >= b - a, do: longest
  defp update_longest(new, _longest), do: new

  defp to_array(s) do
    s
    |> String.codepoints()
    |> Enum.reduce({:array.new(), 0}, fn char, {array, index} ->
      new_array = :array.set(index, char, array)
      {new_array, index + 1}
    end)
  end
end
