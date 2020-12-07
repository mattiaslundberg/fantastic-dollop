defmodule Aoc2020.Day07 do
  def part1(input) do
    rules =
      input
      |> Enum.map(&parse_line/1)
      |> Map.new()

    rules
    |> Map.delete("shiny gold")
    |> Map.keys()
    |> Enum.map(&count_contains(&1, rules, "shiny gold"))
    |> Enum.count(&Function.identity/1)
  end

  def part2(_) do
    :ok
  end

  def parse_line(line) do
    [bag, contents] = String.split(line, " bags contain ")
    {bag, parse_contents(contents)}
  end

  def parse_contents("no other" <> _), do: %{}

  def parse_contents(contents) do
    contents
    |> String.split(", ")
    |> Enum.map(&parse_content/1)
    |> Map.new()
  end

  defp parse_content(content) do
    [count, desc] =
      content
      |> String.split(" ", parts: 2)

    desc = desc |> String.split() |> Enum.take(2) |> Enum.join(" ")

    {desc, count |> String.to_integer()}
  end

  def count_contains(expected, _, expected), do: true

  def count_contains(checking, rules, expected) do
    allowed_in = rules |> Map.get(checking) |> Map.keys()

    allowed_in |> Enum.map(&count_contains(&1, rules, expected)) |> Enum.any?()
  end
end
