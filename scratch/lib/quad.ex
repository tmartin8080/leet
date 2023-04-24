defmodule Quad do
  def has_duplicate_value?(data) do
    data
    |> Enum.with_index()
    |> Enum.map(fn {n, index} ->
      Enum.find_index(data, n)
    end)
  end
end
