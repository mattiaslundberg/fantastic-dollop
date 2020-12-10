defmodule Aoc2020.Day10 do
  def part1(converters) do
    freqs =
      converters
      |> Enum.sort()
      |> List.insert_at(-1, expected_output(converters))
      |> List.insert_at(0, 0)
      |> find_diffs([])
      |> Enum.frequencies()

    Map.get(freqs, 1) * Map.get(freqs, 3)
  end

  def part2(_input) do
    :ok
  end

  def find_diffs([], diffs), do: diffs
  def find_diffs([_], diffs), do: diffs
  def find_diffs([this, next | rest], diffs), do: find_diffs([next | rest], [next - this | diffs])

  def expected_output(converters), do: Enum.max(converters) + 3
end
