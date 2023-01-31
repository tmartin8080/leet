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
    context = %{start: 0, length: 0}
    find_longest(s, string_length, context, start)
  end

  # base case
  defp find_longest(s, string_length, context, start) when start == string_length - 1 do
    longest_from_range(s, context)
  end

  # reduce case
  defp find_longest(s, string_length, context, start) do
    context = expand_range(s, string_length, start, start, context)
    context = expand_range(s, string_length, start, start + 1, context)
    find_longest(s, string_length, context, start + 1)
  end

  defp expand_range(s, string_length, st, en, context) do
    range = 0..(string_length - 1)

    {left, right} =
      Enum.reduce_while(range, {st, en}, fn _, {left, right} ->
        if left >= 0 and right < string_length - 1 and String.at(s, left) == String.at(s, right) do
          dbg("pal")
          {:cont, {left - 1, right + 1}}
        else
          {:halt, {left, right}}
        end
      end)

    dbg(context)
    dbg(left)
    dbg(right)

    if context.length < right - left - 1 do
      %{start: left + 1, length: right - left - 1}
    else
      context
    end
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
