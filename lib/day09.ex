defmodule Aoc2020.Day09 do
  def part1(input, preamble) do
    {previous, check} = Enum.split(input, preamble)
    check_list(previous, check)
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

  def check_list(previous, [check | remaining]) do
    is_sum =
      previous |> Aoc2020.Day01.combinations(2) |> Enum.any?(fn [a, b] -> a + b == check end)

    if is_sum do
      previous |> tl() |> List.insert_at(-1, check) |> check_list(remaining)
    else
      check
    end
  end
end
