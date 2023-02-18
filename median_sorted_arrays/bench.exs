list = Enum.to_list(1..10_000)
array = :array.from_list(list)

Benchee.run(
  %{
    "list.count" => fn -> length(list) end,
    "array.count" => fn -> :array.size(array) end
  },
  time: 10,
  memory_time: 2
)
