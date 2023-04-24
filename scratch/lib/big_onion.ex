defmodule BigOnion do
  def binary_search(data, target) do
    low = 0
    high = tuple_size(data) - 1
    do_binary_search(data, target, low, high)
  end

  defp do_binary_search(data, target, low, high) when low <= high do
    mid = div(low + high, 2)

    case elem(data, mid) do
      value when value == target ->
        mid

      value when value < target ->
        do_binary_search(data, target, mid + 1, high)

      value when value > target ->
        do_binary_search(data, target, low, mid - 1)
    end
  end

  defp do_binary_search(_, _, _, _), do: :not_found
end

defmodule Bubble do
  def sort(list) when is_list(list) do
    make_pass(do_sort(list, []), list)
  end

  def make_pass(bubbled_list, old_list) when bubbled_list != old_list do
    do_sort(bubbled_list, []) |> make_pass(bubbled_list)
  end

  def make_pass(bubbled_list, old_list) when bubbled_list == old_list do
    bubbled_list
  end

  def do_sort(_list = [], _acc) do
    []
  end

  def do_sort([first | []], acc) do
    acc ++ [first]
  end

  def do_sort([first | [second | tail]], acc) do
    [new_first, new_second] = swap(first, second)
    do_sort([new_second | tail], acc ++ [new_first])
  end

  defp swap(e1, e2) do
    if e1 <= e2 do
      [e1, e2]
    else
      [e2, e1]
    end
  end
end
