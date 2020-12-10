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
    max = expected_output(converters)

    converters
    |> Enum.sort()
    |> find_converters_cached(0, 0, max, %{})
    |> elem(0)
  end

  def find_diffs([], diffs), do: diffs
  def find_diffs([_], diffs), do: diffs
  def find_diffs([this, next | rest], diffs), do: find_diffs([next | rest], [next - this | diffs])
  def expected_output(converters), do: Enum.max(converters) + 3

  def find_converters_cached(lst, i, curr, max, cache) do
    cached = Map.get(cache, {i, curr})

    cond do
      not is_nil(cached) ->
        {cached, cache}

      length(lst) <= i ->
        v =
          if curr + 3 < max do
            0
          else
            1
          end

        {v, cache}

      curr > max or curr + 3 < Enum.at(lst, i) ->
        {0, cache}

      true ->
        {used, cache} = find_converters_cached(lst, i + 1, Enum.at(lst, i), max, cache)
        {not_used, cache} = find_converters_cached(lst, i + 1, curr, max, cache)
        res = used + not_used
        {res, Map.put(cache, {i, curr}, res)}
    end
  end

  def find_converters(_, curr, max) when curr > max, do: 0
  def find_converters([converter | _], curr, _max) when curr + 3 < converter, do: 0
  def find_converters([], curr, max) when curr + 3 < max, do: 0
  def find_converters([], _, _), do: 1

  def find_converters([converter | rest], curr, max) do
    used = find_converters(rest, converter, max)
    not_used = find_converters(rest, curr, max)
    used + not_used
  end
end
