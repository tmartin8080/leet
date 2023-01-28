defmodule AddTwoNumbers do
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    n1 = list_to_value(l1)
    n2 = list_to_value(l2)

    (n1 + n2)
    |> to_string()
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.map(fn int_string ->
      Integer.parse(int_string)
      |> case do
        {int, _} ->
          int

        _ ->
          0
      end
    end)
  end

  defp list_to_value(list) do
    list
    |> Enum.with_index()
    |> Enum.reduce(0, fn
      {value, 0}, acc ->
        acc + value

      {value, index}, acc ->
        multiplier = :math.pow(10, index)
        acc + value * multiplier
    end)
    |> trunc()
  end
end
