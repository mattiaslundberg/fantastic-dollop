defmodule Aoc2020.Day14 do
  def part1(input) do
    parsed = Enum.map(input, &parse/1)

    parsed
    |> Enum.reduce({hd(parsed), %{}}, &run_program/2)
    |> elem(1)
    |> Map.values()
    |> Enum.map(&String.to_integer(&1, 2))
    |> Enum.sum()
  end

  def part2(_input) do
    :ok
  end

  def parse("mask = " <> mask), do: [:mask, mask]

  def parse("mem[" <> str) do
    [addr, val] = String.split(str, "] = ")
    [String.to_integer(addr), to_bitstring(val)]
  end

  def to_bitstring(s),
    do: s |> String.to_integer() |> Integer.to_string(2) |> String.pad_leading(36, "0")

  def run_program([:mask, value], {_mask, acc}), do: {value, acc}

  def run_program([addr, value], {mask, acc}),
    do: {mask, Map.put(acc, addr, apply_mask(mask, value))}

  def apply_mask("X" <> mask, <<v::utf8>> <> val), do: <<v::utf8>> <> apply_mask(mask, val)
  def apply_mask("1" <> mask, <<_::utf8>> <> val), do: "1" <> apply_mask(mask, val)
  def apply_mask("0" <> mask, <<_::utf8>> <> val), do: "0" <> apply_mask(mask, val)
  def apply_mask("", ""), do: ""
end
