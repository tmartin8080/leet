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
  """
  require Logger
  @spec longest_palindrome(s :: String.t()) :: String.t()
  def longest_palindrome(s) when s == "" or is_nil(s), do: ""

  def longest_palindrome(s) do
    index = 0
    n = String.length(s) - 1
    IO.inspect("============================ starting - #{s} ============================")
    find_longest({s, n}, index, {0, 0})
  end

  defp find_longest({s, n}, index, {left, right}) when index > n do
    IO.inspect(
      "============================ done | index: #{index} | n: #{n} ============================"
    )

    String.slice(s, left..right)
  end

  defp find_longest(data, index, longest) do
    IO.inspect(
      "-> find_longest | index: #{inspect(index)} | longest: #{inspect(longest)} | value: #{slice(elem(data, 0), longest)}"
    )

    IO.inspect("---> checking odd")
    longest = expand_range(data, index, index, longest)
    IO.inspect("---> checking even")
    longest = expand_range(data, index, index + 1, longest)
    IO.inspect("<- find_longest :result | #{inspect(longest)} | #{slice(elem(data, 0), longest)}")

    Process.sleep(5_000)
    find_longest(data, index + 1, longest)
  end

  defp expand_range({s, n} = data, left, right, longest) when left == right do
    IO.inspect(
      "-----> expand_range :odd | left: #{left} | right: #{right} | longest: #{inspect(longest)} | value: #{slice(s, longest)}"
    )

    new_left = max(left - 1, 0)
    new_right = min(right + 1, n)
    expand_range(data, new_left, new_right, longest)
  end

  defp expand_range({s, n} = data, left, right, longest) when left < right do
    left_string = String.at(s, left)
    right_string = String.at(s, right)

    IO.inspect(
      "-----> expand_range :init | left: #{left} - #{left_string} | right: #{right} - #{right_string} | longest: #{inspect(longest)} | value: #{slice(s, longest)}"
    )

    if String.at(s, left) == String.at(s, right) do
      IO.inspect("-----> expand_range :is_palindrome | current: #{slice(s, longest)}")
      new_longest = update_longest({left, right}, longest)

      expand_range(data, left - 1, right + 1, new_longest)
    else
      IO.inspect(
        "-----> expand_range :no_palindrome | longest: #{inspect(longest)} | value: #{slice(s, longest)}"
      )

      longest
    end
  end

  defp slice(s, {left, right}) do
    String.slice(s, left..right)
  end

  # keep first one found in case of even
  defp update_longest({a, b}, {c, d} = longest) when d - c >= b - a, do: longest
  defp update_longest(new, _longest), do: new
end
