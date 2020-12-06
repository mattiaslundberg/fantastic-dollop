defmodule Aoc2020.Day06 do
  def part1(groups) do
    groups
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&calculate_number/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part2(groups) do
    groups |> Enum.map(&calculate_number2/1) |> Enum.reduce(&Kernel.+/2)
  end

  defp calculate_number(group) do
    group |> String.codepoints() |> Enum.frequencies() |> Map.keys() |> length()
  end

  defp calculate_number2(group) do
    total_people = group |> String.split("\n") |> length

    group
    |> String.replace("\n", "")
    |> String.codepoints()
    |> Enum.frequencies()
    |> Enum.filter(fn {_k, v} -> v == total_people end)
    |> length()
  end
end
