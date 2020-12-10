defmodule Aoc2020.Day10 do
  def part1(converters) do
    freqs =
      converters
      |> Enum.sort()
      |> List.insert_at(-1, expected_output(converters))
      |> List.insert_at(0, 0)
      |> find_diffs([])
      |> Enum.frequencies()

    Map.get(freqs, 1) * Map.get(freqs, 3)
  end

  def part2(converters) do
    converters
    |> Enum.sort()
    |> find_converters_cached(0, 0, expected_output(converters), %{})
    |> elem(0)
  end

  def find_diffs([], diffs), do: diffs
  def find_diffs([_], diffs), do: diffs
  def find_diffs([this, next | rest], diffs), do: find_diffs([next | rest], [next - this | diffs])
  def expected_output(converters), do: Enum.max(converters) + 3

  def find_converters_cached(lst, i, curr, max, cache) do
    cond do
      Map.has_key?(cache, {i, curr}) ->
        {Map.get(cache, {i, curr}), cache}

      length(lst) <= i ->
        v = if curr + 3 < max, do: 0, else: 1
        {v, cache}

      curr + 3 < Enum.at(lst, i) ->
        {0, cache}

      true ->
        {used, cache} = find_converters_cached(lst, i + 1, Enum.at(lst, i), max, cache)
        {not_used, cache} = find_converters_cached(lst, i + 1, curr, max, cache)
        res = used + not_used
        {res, Map.put(cache, {i, curr}, res)}
    end
  end
end
