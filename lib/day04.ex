defmodule Aoc2020.Day04 do
  @required_keys [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
  ]

  def part1(input) do
    required = MapSet.new(@required_keys)

    input
    |> Enum.map(&parse_passport_string/1)
    |> Enum.map(&Map.keys/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.filter(&MapSet.subset?(required, &1))
    |> length()
  end

  def part2(_input) do
    :ok
  end

  defp parse_passport_string(str) do
    str
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.map(&String.split(&1, ":"))
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
