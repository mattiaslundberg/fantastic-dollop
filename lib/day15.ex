defmodule Aoc2020.Day15 do
  def part1(numbers), do: find_spoken_at(numbers, 2021, 1, nil, %{})

  def part2(numbers), do: find_spoken_at(numbers, 30_000_001, 1, nil, %{})

  def find_spoken_at(_, target, target, last, _), do: last

  def find_spoken_at([n | nr], target, turn, _last, cache) do
    cache = Map.update(cache, n, [turn], fn v -> [turn | v] end)

    find_spoken_at(nr, target, turn + 1, n, cache)
  end

  def find_spoken_at([], target, turn, last, cache) do
    new = get_number_to_say(last, cache)
    cache = Map.update(cache, new, [turn], fn v -> [turn | v] end)
    find_spoken_at([], target, turn + 1, new, cache)
  end

  def get_number_to_say(last, cache) do
    case Map.get(cache, last) do
      [v, vv | _] ->
        v - vv

      _ ->
        0
    end
  end
end
