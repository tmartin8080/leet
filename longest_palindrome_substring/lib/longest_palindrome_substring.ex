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
    index = 0
    n = String.length(s)
    find_longest({s, n}, index, {0, 1})
  end

  defp find_longest({s, n}, index, {left, right}) when index > n do
    String.slice(s, left, right)
  end

  defp find_longest(data, index, longest) do
    longest = expand_range(data, index, index, longest)
    longest = expand_range(data, index, index + 1, longest)
    find_longest(data, index + 1, longest)
  end

  defp expand_range(data, left, right, longest) when left == right do
    expand_range(data, left - 1, right + 1, longest)
  end

  defp expand_range({s, n} = data, left, right, longest) when left > 0 and right < n do
    if String.at(s, left) == String.at(s, right) do
      new_longest = {left, right}
      expand_range(data, left - 1, right + 1, new_longest)
    else
      longest
    end
  end

  defp expand_range(_data, _left, _right, longest), do: longest
end
