defmodule LongestPalindromeSubstringString do
  @moduledoc """
  String random-access
  """
  require Logger
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    n = String.length(s) - 1
    find_longest({s, n}, 0, {0, 0})
  end

  defp find_longest({s, n}, index, {left, right}) when index > n do
    String.slice(s, left..right)
  end

  defp find_longest(data, index, longest) do
    longest = expand_range(data, index, index, longest)
    longest = expand_range(data, index, index + 1, longest)
    find_longest(data, index + 1, longest)
  end

  defp expand_range({_s, n} = data, left, right, longest) when left == right do
    new_left = max(left - 1, 0)
    new_right = min(right + 1, n)
    expand_range(data, new_left, new_right, longest)
  end

  defp expand_range({s, n} = data, left, right, longest) when left >= 0 and right <= n do
    if String.at(s, left) == String.at(s, right) do
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
end
