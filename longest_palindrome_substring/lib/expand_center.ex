defmodule ExpandCenter do
  def is_palindrome?(s) do
    string_length = String.length(s)
    window = find_center(string_length)
    expand(s, window)
  end

  # we've expanded beyond the left-most index which means
  # that all steps have passed and the string is a palindrome.
  defp expand(_s, {left, _right}) when left < 0, do: true

  defp expand(s, {left, right}) do
    if String.at(s, left) == String.at(s, right) do
      expand(s, {left - 1, right + 1})
    else
      false
    end
  end

  defp find_center(string_length) do
    if Integer.mod(string_length, 2) == 0 do
      mid = round(string_length / 2)
      {mid - 1, mid}
    else
      mid = round((string_length - 1) / 2)
      {mid, mid}
    end
  end
end
