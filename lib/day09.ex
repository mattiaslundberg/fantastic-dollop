defmodule Aoc2020.Day09 do
  def part1(input, preamble) do
    {previous, check} = Enum.split(input, preamble)
    check_list(previous, check) |> Enum.zip(check) |> Enum.find(fn {a, _} -> not a end) |> elem(1)
  end

  def part2(input, sum) do
    find_sum(0, input, sum, [])
  end

  def find_sum(loc, input, sum, previous_sums) do
    current = Enum.at(input, loc)
    sums = [current | Enum.map(previous_sums, fn x -> x + current end)]
    found_location = Enum.find_index(sums, fn x -> x == sum end)

    if found_location do
      sublist = Enum.slice(input, loc - found_location, found_location + 1)
      Enum.min(sublist) + Enum.max(sublist)
    else
      find_sum(loc + 1, input, sum, sums)
    end
  end

  def check_list(_, []), do: []

  def check_list(previous, [check | remaining]) do
    is_sum =
      previous |> Aoc2020.Day01.combinations(2) |> Enum.any?(fn [a, b] -> a + b == check end)

    new_previous = List.insert_at(tl(previous), -1, check)

    [is_sum | check_list(new_previous, remaining)]
  end
end
