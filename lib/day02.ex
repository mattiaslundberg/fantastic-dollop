defmodule Aoc2020.Day02 do
  def part1(input) do
    input
    |> Enum.map(fn line ->
      {least, most, char, pass} = parse_line(line)
      valid?(least, most, char, pass)
    end)
    |> Enum.count(fn v -> v end)
  end

  def part2(input) do
    input
    |> Enum.map(fn line ->
      {first, last, char, pass} = parse_line(line)
      valid_pos?(first, last, char, pass)
    end)
    |> Enum.count(fn v -> v end)
  end

  def parse_line(line) do
    [count, char, pass] = String.split(line, " ")
    [least, most] = String.split(count, "-")
    char = String.replace(char, ":", "")

    {String.to_integer(least), String.to_integer(most), char, pass}
  end

  def valid_pos?(first, last, char, pass) do
    fc = String.at(pass, first - 1)
    lc = String.at(pass, last - 1)

    (fc == char or lc == char) and fc != lc
  end

  def valid?(least, most, char, pass) do
    count = contains(char, pass)

    count >= least and count <= most
  end

  def contains(_, ""), do: 0
  def contains(char = <<m>>, <<m::utf8>> <> rest), do: 1 + contains(char, rest)
  def contains(char, <<_::utf8>> <> rest), do: contains(char, rest)
end
