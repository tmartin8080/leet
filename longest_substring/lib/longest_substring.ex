defmodule LongestSubstring do
  @moduledoc """
  Given a string s, find the length of the longest substring without
  repeating characters.

  Traverse the string with a sliding window - left and right indices.

  Stores the index of previously seen chars in a map:

    seen_map #=> %{char => index}

  If char at position `window_right` has already been seen at prev_pos,
  set `window_left` to prev_pos + 1.

  In any case: Increment `window_right.

  Repeat, keeping max of `window_right-window_left`.
  """
  @window_left 0
  @window_right 0
  @seen_map %{}
  @substring_length 0

  @spec length_of_longest_substring(s :: String.t()) :: integer
  def length_of_longest_substring(s) do
    charlist = String.to_charlist(s)
    get_length(s, @window_left, @window_right, @seen_map, @substring_length, charlist)
  end

  def get_length(_s, _, _, _, substring_length, []), do: substring_length

  def get_length(s, window_left, window_right, seen_map, substring_length, [char | tail]) do
    case Map.get_and_update(seen_map, char, &{&1, window_right}) do
      {char_index, new_seen_map} when char_index == nil or char_index < window_left ->
        # duplicate not found (char not seen OR char_index positioned before left window)
        # - keep left position and slide right +1
        # - determine new longest substring
        new_substring_length = max(window_right - window_left + 1, substring_length)
        get_length(s, window_left, window_right + 1, new_seen_map, new_substring_length, tail)

      {char_index, new_seen_map} ->
        # duplicate found - slide left index +1 beyond duplicate, and slide right +1
        get_length(s, char_index + 1, window_right + 1, new_seen_map, substring_length, tail)
    end
  end
end
