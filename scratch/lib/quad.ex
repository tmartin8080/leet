defmodule Quad do
  def has_duplicate_value?(data) do
    data
    |> Enum.with_index()
    |> Enum.flat_map(fn {val1, index1} ->
      data
      |> Enum.with_index()
      |> Enum.map(fn {val2, index2} ->
        if val1 == val2 and index1 != index2 do
          true
        else
          false
        end
      end)
    end)
    |> Enum.any?(&(&1 == true))
  end
end
