defmodule TwoPointers do
  def is_palindrome?(s) do
    range = {0, max(String.length(s) - 1, 0)}
    check_pointers(s, range)
  end

  defp check_pointers(_s, {low, high}) when low > high, do: true

  defp check_pointers(s, {low, high}) do
    left = String.at(s, low)
    right = String.at(s, high)
    dbg()

    if left == right do
      check_pointers(s, {low + 1, high - 1})
    else
      false
    end
  end
end
