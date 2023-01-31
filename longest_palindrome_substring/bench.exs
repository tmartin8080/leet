s = :binary.copy("z", 1000)

Benchee.run(
  %{
    "array" => fn -> LongestPalindromeSubstringArray.longest_palindrome(s) end,
    "map" => fn -> LongestPalindromeSubstring.longest_palindrome(s) end
  },
  time: 10,
  memory_time: 2
)
