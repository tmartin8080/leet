list = Enum.to_list(1..10_000)
array = :array.from_list(list)

Benchee.run(
  %{
    "Enum.count/1" => fn -> length(list) end,
    ":array.size/1" => fn -> :array.size(array) end
  },
  time: 10,
  memory_time: 2
)

Benchee.run(
  %{
    "Enum.at/2" => fn -> Enum.at(list, 5000) end,
    ":array.get/2" => fn -> :array.get(5000, array) end
  },
  time: 10,
  memory_time: 2
)
