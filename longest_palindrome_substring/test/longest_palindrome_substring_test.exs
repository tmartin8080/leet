defmodule LongestPalindromeSubstringTest do
  use ExUnit.Case
  import LongestPalindromeSubstring

  describe "longest_palindrome/1" do
    test "finds longest" do
      assert longest_palindrome("babad") == "bab"
      # assert longest_palindrome("cbbd") == "bb"
    end
  end
end
