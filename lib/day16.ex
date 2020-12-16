defmodule Aoc2020.Day16 do
  def part1([restrictions, _my, other]) do
    allowed_nums =
      restrictions
      |> parse_restrictions()
      |> get_allowed_nums()

    other
    |> parse_tickets()
    |> Enum.map(&sum_invalid(&1, allowed_nums))
    |> Enum.sum()
  end

  def part2([restrictions, my, other]) do
    restrictions = restrictions |> parse_restrictions()

    allowed_nums = restrictions |> get_allowed_nums()

    valid_tickets =
      other
      |> parse_tickets()
      |> Enum.filter(&ticket_valid(&1, allowed_nums))

    my = my |> parse_tickets() |> Enum.at(0)

    restrictions
    |> get_valid_order(valid_tickets)
    |> elem(0)
    |> Map.values()
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
      |> Enum.reduce([], &parse_range/2)
      |> MapSet.new()

    {label, res}
  end

  defp parse_range(a, acc) do
    [l, h] = String.split(a, "-") |> Enum.map(&String.to_integer/1)
    l..h |> Enum.reduce(acc, fn b, acc -> [b | acc] end)
  end

  def parse_tickets(input),
    do: input |> String.split("\n") |> Enum.drop(1) |> Enum.map(&parse_ticket/1)

  def parse_ticket(ticket), do: ticket |> String.split(",") |> Enum.map(&String.to_integer/1)

  def sum_invalid(lst, allowed_nums) do
    lst
    |> Enum.reject(&MapSet.member?(allowed_nums, &1))
    |> Enum.sum()
  end

  defp ticket_valid(t, allowed_nums), do: Enum.all?(t, &MapSet.member?(allowed_nums, &1))

  def get_allowed_nums(restrictions),
    do: restrictions |> Map.values() |> Enum.reduce(MapSet.new(), &MapSet.union(&2, &1))

  def get_valid_order(restrictions, valid_tickets) do
    valid_tickets
    |> Enum.reduce(Map.new(), &update_with_ticket(&1, &2, restrictions))
    |> Enum.sort(fn {_, v1}, {_, v2} -> MapSet.size(v1) <= MapSet.size(v2) end)
    |> Enum.reduce({Map.new(), MapSet.new()}, fn {index, set}, {map, used} ->
      [value] = set |> MapSet.difference(used) |> MapSet.to_list()

      {Map.put(map, index, value), MapSet.put(used, value)}
    end)
  end

  def update_with_ticket(ticket, acc, restrictions) do
    ticket
    |> get_allowed_for_ticket(restrictions)
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
