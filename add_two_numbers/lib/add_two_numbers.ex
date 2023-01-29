defmodule AddTwoNumbers do
  @moduledoc """
  1. Convert Linked List to Integer (already reversed)
  2. Split sum into list: [1, 2, 3]
  3. Reverse list
  4. Re-build linked list result using recursion.
  """
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    (list_to_integer(l1) + list_to_integer(l2))
    |> Integer.digits()
    |> Enum.reverse()
    |> to_linked_list()
  end

  defp list_to_integer(linked_list), do: list_to_integer(linked_list, 0, 1)

  defp list_to_integer(nil, total, _), do: total

  defp list_to_integer(%ListNode{val: current_value, next: next_node}, total, multiplier) do
    new_total = total + current_value * multiplier
    new_multiplier = multiplier * 10
    list_to_integer(next_node, new_total, new_multiplier)
  end

  defp to_linked_list([]), do: nil

  defp to_linked_list([h | tail]) do
    %ListNode{val: h, next: to_linked_list(tail)}
  end
end
