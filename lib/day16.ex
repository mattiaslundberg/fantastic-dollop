defmodule Aoc2020.Day16 do
  def part1([restrictions, _my, other]) do
    allowed_nums =
      restrictions
      |> parse_restrictions()
      |> Enum.reduce(MapSet.new(), fn {_, x}, acc ->
        Enum.reduce(x, acc, &MapSet.put(&2, &1))
      end)

    other
    |> parse_tickets()
    |> Enum.reduce(0, &sum_invalid(&1, &2, allowed_nums))
  end

  def part2(_input) do
    :ok
  end

  def parse_restrictions(input), do: input |> String.split("\n") |> Enum.map(&parse_restriction/1)

  def parse_restriction(r) do
    [label, range] = String.split(r, ": ")

    res =
      range
      |> String.split(" or ")
      |> Enum.reduce([], fn a, acc ->
        [l, h] = String.split(a, "-") |> Enum.map(&String.to_integer/1)
        l..h |> Enum.reduce(acc, fn b, acc -> [b | acc] end)
      end)

    {label, res}
  end

  def parse_tickets(input),
    do: input |> String.split("\n") |> Enum.drop(1) |> Enum.map(&parse_ticket/1)

  def parse_ticket(ticket), do: ticket |> String.split(",") |> Enum.map(&String.to_integer/1)

  def sum_invalid(lst, acc, allowed_nums) do
    res =
      lst
      |> Enum.reject(&MapSet.member?(allowed_nums, &1))
      |> Enum.sum()

    res + acc
  end
end
