defmodule LongestPalindromeSubstring do
  @moduledoc """
  class Solution {
    public String longestPalindrome(String s) {
        if (s == null || s.length() < 1) return "";
        int start = 0, end = 0;
        for (int i = 0; i < s.length(); i++) {
            int len1 = expandAroundCenter(s, i, i);
            int len2 = expandAroundCenter(s, i, i + 1);
            int len = Math.max(len1, len2);
            if (len > end - start) {
                start = i - (len - 1) / 2;
                end = i + len / 2;
            }
        }
        return s.substring(start, end + 1);
    }

    private int expandAroundCenter(String s, int left, int right) {
        int L = left, R = right;
        while (L >= 0 && R < s.length() && s.charAt(L) == s.charAt(R)) {
            L--;
            R++;
        }
        return R - L - 1;
    }
  }

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
    start_index = 0
    end_index = 0
    chars = String.codepoints(s)
    find_palindrome(chars, start_index, end_index)
  end

  defp find_palindrome(s, start_index, end_index) do
    dbg()
    expand_around_center(s, 0, 0)
    s
  end

  defp expand_around_center(s, left, right) do
    dbg()
  end
end
