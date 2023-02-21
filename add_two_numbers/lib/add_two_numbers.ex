defmodule AddTwoNumbers do
  @moduledoc """
  1. Convert Linked List to Integer (already reversed)
  2. Split sum into list: [1, 2, 3]
  3. Reverse list
  4. Re-build linked list result using recursion.
  """
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    total = 0
    exponent = 1
    value1 = list_to_integer(l1, total, exponent)
    value2 = list_to_integer(l2, total, exponent)

    (value1 + value2)
    |> Integer.digits()
    |> Enum.reverse()
    |> to_linked_list()
  end

  defp list_to_integer(nil, total, _), do: total

  defp list_to_integer(node, total, exponent) do
    %ListNode{val: current_value, next: next_node} = node
    new_total = total + current_value * exponent
    new_exponent = exponent * 10
    list_to_integer(next_node, new_total, new_exponent)
  end

  defp to_linked_list([]), do: nil

  defp to_linked_list([h | tail]) do
    %ListNode{val: h, next: to_linked_list(tail)}
  end
end
