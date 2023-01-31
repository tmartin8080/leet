defmodule LongestPalindromeSubstringTest do
  use ExUnit.Case
  import LongestPalindromeSubstring

  describe "longest_palindrome/1" do
    test "finds longest a" do
      assert longest_palindrome("babad") == "bab"
    end

    test "finds longest b" do
      assert longest_palindrome("cbbd") == "bb"
    end

    test "finds longest blob" do
      s =
        "abababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababababa"

      assert longest_palindrome(s) == s
    end
  end
end
