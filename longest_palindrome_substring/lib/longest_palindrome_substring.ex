defmodule LongestPalindromeSubstring do
  @moduledoc """
  """
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    start = 0
    string_length = String.length(s)
    longest = String.slice(s, 0..1)
    find_longest(s, string_length, longest, start)
  end

  defp find_longest(s, string_length, longest, start) when start == string_length - 1 do
    longest
  end

  defp find_longest(s, string_length, longest, start) do
    new_longest =
      s
      |> expand_range(string_length, start, start)
      |> get_longest(longest)

    new_longest =
      s
      |> expand_range(string_length, start, start + 1)
      |> get_longest(new_longest)

    find_longest(s, string_length, new_longest, start + 1)
  end

  defp expand_range(s, string_length, left, right) when left >= 0 and right <= string_length do
    {left, right} =
      if String.at(s, left) == String.at(s, right) do
        {left - 1, right + 1}
      else
        {left, right}
      end

    longest_from_range(s, {left, right})
  end

  defp expand_range(s, _string_length, left, right) do
    longest_from_range(s, {left, right})
  end

  defp get_longest(new_longest, current_longest) do
    if String.length(new_longest) > String.length(current_longest) do
      new_longest
    else
      current_longest
    end
  end

  defp longest_from_range(s, {left, right}) do
    String.slice(s, left..right)
  end
end
