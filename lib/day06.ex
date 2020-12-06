defmodule Aoc2020.Day06 do
  def part1(groups) do
    groups |> Enum.map(&calculate_number/1) |> Enum.reduce(&Kernel.+/2)
  end

  def part2(_groups) do
    :ok
  end

  defp calculate_number(group) do
    group |> String.codepoints() |> Enum.frequencies() |> Map.keys() |> length()
  end
end
