defmodule LongestPalindromeSubstring do
  @moduledoc """
  # Javascript
  const longestPalindrome = s => {
    if(!s || s.length <= 1) {
      return s
    }
    let longest = s.substring(0, 1)
    for(let i = 0; i < s.length; i++) {
      let temp = expand(s, i, i)
      if(temp.length > longest.length) {
        longest = temp
      }
      temp = expand(s, i, i + 1)
      if(temp.length > longest.length) {
        longest = temp
      }
    }
    return longest
  }

  const expand = (s, begin, end) => {
    while(begin >= 0 && end <= s.length - 1 && s[begin] === s[end]) {
      begin--
      end++
    }
    return s.substring(begin + 1, end)
  }
  """
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    index = 0
    longest = String.slice(s, 0..1)
    result = find_longest(s, longest, index)
  end

  defp find_longest(s, longest, index) when length(s) == index - 1do
    longest
  end

  defp find_longest(s, longest, index) do
    temp = expand(s, index, index)

    longest =
      if String.length(temp) > String.length(longest) do
        temp
      else
        longest
      end

    temp = expand(s, index, index + 1)

    longest =
      if String.length(temp) > String.length(longest) do
        temp
      else
        longest
      end

    longest
    find_longest(s, longest, index + 1)
  end

  defp expand(s, left, right) do
    {left, right} =
      Enum.reduce(0..String.length(s), {0, 0}, fn _n, {left, right} = acc ->
        if left > 0 and right <= String.length(s) - 1 and
             String.at(s, left) == String.at(s, right) do
          {left - 1, right + 1}
        else
          acc
        end
      end)

    String.slice(s, left..right)
  end
end
