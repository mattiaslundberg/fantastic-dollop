defmodule Aoc2020.Day09 do
  def part1(input, preamble) do
    {previous, check} = Enum.split(input, preamble)
    check_list(previous, check) |> Enum.zip(check) |> Enum.find(fn {a, _} -> not a end) |> elem(1)
  end

  def part2(input) do
    :ok
  end

  def check_list(_, []), do: []

  def check_list(previous, [check | remaining]) do
    is_sum =
      previous |> Aoc2020.Day01.combinations(2) |> Enum.any?(fn [a, b] -> a + b == check end)

    new_previous = List.insert_at(tl(previous), -1, check)

    [is_sum | check_list(new_previous, remaining)]
  end
end
