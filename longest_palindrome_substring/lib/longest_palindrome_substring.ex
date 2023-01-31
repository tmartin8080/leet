defmodule LongestPalindromeSubstring do
  @moduledoc """
  fn1(s) {
    int strLength = s.length()
    if (strLength < 2) { return s }
    for (int start = 0, start < strLength -1; start++) {
      expandRange(s, start, start)
      expandRange(s, start, start + 1)
    }
    return s.substring(resultStart, resultStart + resultLength)
  }

  expandRange(str, begin, end) {
    while (begin >= 0 && end < str.length() && str.charAt(begin) == str.charAt(end)) {
      begin--;
      end++;
    }

    if (resultLength < end - begin -1) {
      resultStart = begin + 1;
      resultLength = end - begin -1;
    }
  }

  """
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    start = 0
    string_length = String.length(s)
    result = %{start: 0, length: 1}
    find_longest(s, string_length, result, start)
  end

  # base case
  defp find_longest(s, string_length, result, start) when start == string_length - 1 do
    longest_from_range(s, result)
  end

  # reduce case
  defp find_longest(s, string_length, result, start) do
    result = expand_range(s, string_length, start, start, result)
    # range2 = expand_range(s, string_length, start, start + 1)
    dbg(result)
    find_longest(s, string_length, %{result_start: 1, result_length: 1}, start + 1)
  end

  defp expand_range(s, string_length, left, right, %{start: _start, length: _length}) do
    string_length
    |> dbg()
    |> Stream.unfold(fn _ ->
      if left >= right and right < string_length and String.at(s, left) == String.at(s, right) do
        {left - 1, right + 1}
      else
        nil
      end
    end)
    |> Stream.run()
    |> dbg()
  end

  # defp get_longest(new_longest, current_longest) do
  #   if String.length(new_longest) > String.length(current_longest) do
  #     new_longest
  #   else
  #     current_longest
  #   end
  # end

  defp longest_from_range(s, %{start: start, length: length}) do
    range = start..(start + length)
    String.slice(s, range)
  end
end
