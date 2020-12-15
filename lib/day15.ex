defmodule Aoc2020.Day15 do
  def part1(numbers), do: find_spoken_at(numbers, 2020, 1, nil, %{})

  def part2(numbers), do: find_spoken_at(numbers, 30_000_000, 1, nil, %{})

  def find_spoken_at(_, target, turn, last, _) when target + 1 == turn, do: last

  def find_spoken_at([n | nr], target, turn, _last, cache) do
    cache = update_cache(cache, n, turn)
    find_spoken_at(nr, target, turn + 1, n, cache)
  end

  def find_spoken_at([], target, turn, last, cache) do
    new = cache |> Map.get(last) |> number_to_say()
    cache = update_cache(cache, new, turn)
    find_spoken_at([], target, turn + 1, new, cache)
  end

  def number_to_say([v, vv]), do: v - vv
  def number_to_say(_), do: 0

  def update_cache(cache, new, turn), do: Map.update(cache, new, [turn], &[turn, hd(&1)])
end
