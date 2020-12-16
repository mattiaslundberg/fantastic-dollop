defmodule Aoc2020.Day16 do
  def part1([restrictions, _my, other]) do
    allowed_nums =
      restrictions
      |> parse_restrictions()
      |> Map.values()
      |> Enum.reduce(MapSet.new(), fn x, acc ->
        Enum.reduce(x, acc, &MapSet.put(&2, &1))
      end)

    other
    |> parse_tickets()
    |> Enum.reduce(0, &sum_invalid(&1, &2, allowed_nums))
  end

  def part2([restrictions, my, other]) do
    restrictions =
      restrictions
      |> parse_restrictions()

    allowed_nums =
      restrictions
      |> Map.values()
      |> Enum.reduce(MapSet.new(), &MapSet.union(&2, &1))

    valid_tickets =
      other
      |> parse_tickets()
      |> Enum.filter(fn t ->
        Enum.all?(t, &MapSet.member?(allowed_nums, &1))
      end)

    order = get_valid_order(restrictions, valid_tickets)

    my = my |> parse_tickets() |> Enum.at(0)

    order
    |> elem(0)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.zip(my)
    |> Enum.reduce(1, fn {o, m}, acc ->
      if String.starts_with?(o, "departure") do
        acc * m
      else
        acc
      end
    end)
  end

  def parse_restrictions(input),
    do: input |> String.split("\n") |> Enum.map(&parse_restriction/1) |> Map.new()

  def parse_restriction(r) do
    [label, range] = String.split(r, ": ")

    res =
      range
      |> String.split(" or ")
      |> Enum.reduce([], fn a, acc ->
        [l, h] = String.split(a, "-") |> Enum.map(&String.to_integer/1)
        l..h |> Enum.reduce(acc, fn b, acc -> [b | acc] end)
      end)
      |> MapSet.new()

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

  def get_valid_order(restrictions, valid_tickets) do
    valid_tickets
    |> Enum.reduce(Map.new(), &update_with_ticket(&1, &2, restrictions))
    |> Enum.sort(fn {_, v1}, {_, v2} -> MapSet.size(v1) <= MapSet.size(v2) end)
    |> Enum.reduce({Map.new(), MapSet.new()}, fn {index, set}, {map, used} ->
      [value] = MapSet.difference(set, used) |> MapSet.to_list()

      {Map.put(map, index, value), MapSet.put(used, value)}
    end)
  end

  def update_with_ticket(ticket, acc, restrictions) do
    allowed_for_this = get_allowed_for_ticket(ticket, restrictions)

    allowed_for_this
    |> Enum.reduce(acc, fn {i, allowed}, acc2 ->
      case Map.get(acc2, i) do
        nil -> Map.put(acc2, i, allowed)
        old -> Map.put(acc2, i, MapSet.intersection(old, allowed))
      end
    end)
  end

  def get_allowed_for_ticket(ticket, restrictions) do
    ticket
    |> Stream.with_index()
    |> Enum.reduce(Map.new(), fn {v, i}, acc ->
      allowed =
        restrictions
        |> Enum.filter(fn {_, values} -> MapSet.member?(values, v) end)
        |> Enum.map(fn {k, _} -> k end)
        |> MapSet.new()

      Map.put(acc, i, allowed)
    end)
  end
end
