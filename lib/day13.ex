defmodule Aoc2020.Day13 do
  def part1(input) do
    [time, bus_ids] = input |> parse()

    {bus_id, wait} =
      bus_ids |> Enum.map(&best_for_bus(time, &1)) |> Enum.min(fn {_, a}, {_, b} -> a <= b end)

    bus_id * wait
  end

  def part2(_input) do
    :ok
  end

  def best_for_bus(time, bus_id) do
    {bus_id, bus_id * ceil(time / bus_id) - time}
  end

  def parse([time, bus_ids]),
    do: [String.to_integer(time), bus_ids |> String.split(",") |> parse_bus_ids()]

  def parse_bus_ids([]), do: []
  def parse_bus_ids(["x" | rest]), do: parse_bus_ids(rest)
  def parse_bus_ids([id | rest]), do: [String.to_integer(id) | parse_bus_ids(rest)]
end
