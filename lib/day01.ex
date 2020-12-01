defmodule Aoc2020.Day01 do
  def find_with_sum([first | values], expected_sum) do
    matching = values |> Enum.filter(fn x -> first + x == expected_sum end)

    case matching do
      [match | _] ->
        {first, match}

      [] ->
        find_with_sum(values, expected_sum)
    end
  end

  def find_with_sum(_, _), do: nil

  def part1(input) do
    {a, b} = find_with_sum(input, 2020)
    a * b
  end
end
