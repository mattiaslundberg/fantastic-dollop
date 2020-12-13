defmodule Aoc2020.Day13 do
  def part1(input) do
    [time, bus_ids] = input |> parse()

    {bus_id, wait} =
      bus_ids
      |> Enum.filter(&(&1 > 1))
      |> Enum.map(&best_for_bus(time, &1))
      |> Enum.min(fn {_, a}, {_, b} -> a <= b end)

    bus_id * wait
  end

  def part2(input) do
    [_, bus_ids] = parse(input)
    prod = bus_ids |> Enum.reduce(&Kernel.*/2)
    sum = get_sum(bus_ids, prod)

    prod - rem(sum, prod)
  end

  def get_sum(bus_ids, prod) do
    bus_ids
    |> Stream.with_index()
    |> Enum.reduce(0, fn {b, i}, acc ->
      p = floor(prod / b)
      acc + i * mul_inv(p, b, 1) * p
    end)
  end

  def mul_inv(p, b, x) do
    case rem(x * p, b) do
      a when a <= 1 -> x
      _ -> mul_inv(p, b, x + 1)
    end
  end

  def best_for_bus(time, bus_id), do: {bus_id, bus_id * ceil(time / bus_id) - time}

  def parse([time, bus_ids]),
    do: [String.to_integer(time), bus_ids |> String.split(",") |> parse_bus_ids()]

  def parse_bus_ids([]), do: []
  def parse_bus_ids(["x" | rest]), do: [1 | parse_bus_ids(rest)]
  def parse_bus_ids([id | rest]), do: [String.to_integer(id) | parse_bus_ids(rest)]
end
