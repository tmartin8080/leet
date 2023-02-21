defmodule TwoPointersTest do
  use ExUnit.Case
  import TwoPointers

  describe "is_palindrome?/1" do
    test "palindrome returns true" do
      assert is_palindrome?("civic")
    end
  end
end
