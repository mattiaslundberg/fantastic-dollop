defmodule Aoc2020.Day01 do
  def combinations(_, 0), do: [[]]
  def combinations([], _), do: []

  def combinations([h | t], m) do
    for(l <- combinations(t, m - 1), do: [h | l]) ++ combinations(t, m)
  end

  def find_with_sum(values, expected_sum, num \\ 2) do
    matching =
      values
      |> combinations(num)
      |> Enum.filter(fn x -> Enum.sum(x) == expected_sum end)

    case matching do
      [match | _] ->
        match

      [] ->
        find_with_sum(values, expected_sum)
    end
  end

  def part1(input) do
    input |> find_with_sum(2020) |> Enum.reduce(&Kernel.*/2)
  end
end
