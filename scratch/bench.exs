range = 10_000_000_000..10_000_050_000

phone_numbers =
  Enum.reduce(range, [], fn num, acc ->
    ["+#{num}" | acc]
  end)

capacity = length(phone_numbers)

defmodule Do do
  def map_set(phone_numbers) do
    Enum.reduce(phone_numbers, MapSet.new(), fn phone, set ->
      if MapSet.member?(set, phone) do
        set
      else
        MapSet.put(set, phone)
      end
    end)
  end

  def bloom_filter(phone_numbers, capacity) do
    Enum.reduce(phone_numbers, BloomFilter.new(capacity, 0.1), fn phone, f ->
      if BloomFilter.has?(f, phone) do
        f
      else
        BloomFilter.add(f, phone)
      end
    end)
  end

  def bloomex(phone_numbers, capacity) do
    Enum.reduce(phone_numbers, Bloomex.scalable(capacity, 0.1, 0.1, 2), fn phone, f ->
      if Bloomex.member?(f, phone) do
        f
      else
        Bloomex.add(f, phone)
      end
    end)
  end
end

Benchee.run(
  %{
    "map_set" => fn -> Do.map_set(phone_numbers) end,
    # "bloom_filter" => fn -> Do.bloom_filter(phone_numbers, capacity) end,
    "bloomex" => fn -> Do.bloomex(phone_numbers, capacity) end
  },
  time: 10,
  memory_time: 2
)
