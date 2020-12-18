defmodule Aoc2020.Day18 do
  def part1(input) when is_binary(input), do: part1([input])

  def part1(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      acc + (line |> String.replace(" ", "") |> calc([]))
    end)
  end

  def part2(input) when is_binary(input), do: part2([input])

  def part2(input) do
    input
    |> Enum.reduce(0, fn line, acc ->
      acc + (line |> String.replace(" ", "") |> calc_add([]) |> as_string() |> calc([]))
    end)
  end

  def as_string([a | rest]) when is_number(a), do: Integer.to_string(a) <> as_string(rest)
  def as_string([a | rest]), do: a <> as_string(rest)
  def as_string([]), do: ""

  def calc_add("", [current]), do: [current]
  def calc_add("+" <> rest, [prev]), do: calc_add(rest, [&Kernel.+/2, prev])
  def calc_add("*" <> rest, [prev]), do: [prev, "*" | calc_add(rest, [])]

  def calc_add("(" <> rest, prev) do
    [inner, remaining] = find_end(rest, 0)
    inner_res = inner |> calc_add([]) |> as_string() |> calc([])

    case prev do
      [op, prev_res] ->
        calc_add(remaining, [op.(prev_res, inner_res)])

      [] ->
        calc_add(remaining, [inner_res])
    end
  end

  def calc_add(<<c::utf8>> <> rest, current) do
    new_val = String.to_integer(<<c::utf8>>)

    case {current, new_val} do
      {[op, v1], v2} ->
        calc_add(rest, [op.(v1, v2)])

      {[], v} ->
        calc_add(rest, [v])
    end
  end

  def calc("", [current]), do: current

  def calc("+" <> rest, [prev]), do: calc(rest, [&Kernel.+/2, prev])
  def calc("*" <> rest, [prev]), do: calc(rest, [&Kernel.*/2, prev])

  def calc("(" <> rest, prev) do
    [inner, remaining] = find_end(rest, 0)
    inner_res = calc(inner, [])

    case prev do
      [op, prev_res] ->
        calc(remaining, [op.(prev_res, inner_res)])

      [] ->
        calc(remaining, [inner_res])
    end
  end

  def calc(str, current) do
    new_val = Integer.parse(str)

    case {current, new_val} do
      {[op, v1], {v2, rest}} ->
        calc(rest, [op.(v1, v2)])

      {[], {v2, rest}} ->
        calc(rest, [v2])
    end
  end

  def find_end(")" <> r, 0), do: ["", r]

  def find_end(<<char::utf8>> <> r, c) do
    [inner, remaining] =
      case <<char::utf8>> do
        "(" -> find_end(r, c + 1)
        ")" -> find_end(r, c - 1)
        _ -> find_end(r, c)
      end

    [<<char::utf8>> <> inner, remaining]
  end
end
