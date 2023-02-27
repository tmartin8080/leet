defmodule LongestSubstringTest do
  use ExUnit.Case
  import LongestSubstring

  test "length_of_longest_substring/1" do
    assert length_of_longest_substring("") == 0
    assert length_of_longest_substring("abcabcbb") == 3
    assert length_of_longest_substring("bbbbb") == 1
    assert length_of_longest_substring("pwwkew") == 3
    assert length_of_longest_substring("abcdefg") == 7
    assert length_of_longest_substring("abcadefg") == 7
    assert length_of_longest_substring("abcabcda") == 4
    assert length_of_longest_substring("abacadabcd") == 4
  end
end
