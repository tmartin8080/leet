defmodule LongestPalindromeSubstringReduce do
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

  ## Java
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
    range = Range.new(0, string_length - 1)
    chars = string_to_map(s)
    find_longest(s, string_length, chars, range, context, start)
  end

  # base case
  defp find_longest(s, string_length, _chars, _range, context, start)
       when start == string_length - 1 do
    longest_from_range(s, context)
  end

  # reduce case
  defp find_longest(s, string_length, chars, range, context, start) do
    context = expand_range(s, string_length, chars, range, start, start, context)
    context = expand_range(s, string_length, chars, range, start, start + 1, context)
    find_longest(s, string_length, chars, range, context, start + 1)
  end

  defp expand_range(_s, string_length, chars, range, st, en, context) do
    {left, right} =
      Enum.reduce_while(range, {st, en}, fn _n, {left, right} ->
        if left >= 0 and right < string_length and Map.get(chars, left) == Map.get(chars, right) do
          {:cont, {left - 1, right + 1}}
        else
          {:halt, {left, right}}
        end
      end)

    new_start = left + 1
    new_length = right - left - 1

    if new_length > context.length do
      %{context | start: new_start, length: new_length}
    else
      context
    end
  end

  defp longest_from_range(s, %{start: start, length: length}) do
    range = start..(start + length - 1)
    String.slice(s, range)
  end

  defp string_to_map(s) do
    s
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.reduce({%{}, 0}, fn char, {acc, index} ->
      new_map = Map.put(acc, index, char)
      {acc, index + 1}
    end)
  end
end
