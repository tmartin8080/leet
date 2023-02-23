defmodule ExpandCenterTest do
  use ExUnit.Case
  import ExpandCenter

  describe "is_palindrome?/1" do
    test "odd length palindrome returns true" do
      assert is_palindrome?("civic")
    end

    test "even length palindrome returns true" do
      assert is_palindrome?("abba")
    end

    test "non-palindrome returns false" do
      refute is_palindrome?("adffdl")
    end
  end
end
