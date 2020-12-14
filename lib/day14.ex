defmodule Aoc2020.Day14 do
  def part1(input), do: run(input, &run_program/2)

  def part2(input), do: run(input, &run_program2/2)

  def run(input, run_fn) do
    parsed = Enum.map(input, &parse/1)

    parsed
    |> Enum.reduce({hd(parsed), %{}}, run_fn)
    |> elem(1)
    |> Map.values()
    |> Enum.map(&String.to_integer(&1, 2))
    |> Enum.sum()
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

  def run_program2([:mask, value], {_mask, acc}), do: {value, acc}

  def run_program2([addr, value], {mask, acc}) do
    a = addr |> Integer.to_string(2) |> String.pad_leading(36, "0")
    all_addresses = get_addresses(mask, a)

    new_map = Enum.reduce(all_addresses, acc, fn a, acc -> Map.put(acc, a, value) end)
    {mask, new_map}
  end

  def get_addresses("X" <> mask, <<_::utf8>> <> val) do
    mask
    |> get_addresses(val)
    |> Enum.reduce([], fn r, acc -> ["1" <> r, "0" <> r | acc] end)
  end

  def get_addresses("0" <> mask, <<v::utf8>> <> val) do
    mask |> get_addresses(val) |> Enum.map(fn x -> <<v::utf8>> <> x end)
  end

  def get_addresses("1" <> mask, <<_::utf8>> <> val) do
    mask |> get_addresses(val) |> Enum.map(fn x -> "1" <> x end)
  end

  def get_addresses("", ""), do: [""]
end
