defmodule Aoc2020.Day15 do
  def part1(numbers), do: find_spoken_at(numbers, 1, [])

  def part2(_input) do
    :ok
  end

  def find_spoken_at(_, 2021, seen), do: hd(seen)
  def find_spoken_at([n | nr], turn, seen), do: find_spoken_at(nr, turn + 1, [n | seen])

  def find_spoken_at([], turn, [a | seen]),
    do: find_spoken_at([], turn + 1, [get_number_to_say(turn, [a | seen]), a | seen])

  def get_number_to_say(turn, [a | seen]) do
    case get_last_seen(turn - 1, a, [a | seen], []) do
      [v, vv | _] ->
        v - vv

      _ ->
        0
    end
  end

  def get_last_seen(turn, a, [a | seen], found),
    do: get_last_seen(turn - 1, a, seen, [turn | found])

  def get_last_seen(0, _, _, found), do: found |> Enum.reverse()
  def get_last_seen(_, _, [], found), do: found |> Enum.reverse()
  def get_last_seen(turn, a, [_ | seen], found), do: get_last_seen(turn - 1, a, seen, found)
end
