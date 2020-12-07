defmodule Aoc2020.Day07 do
  def part1(input) do
    rules = parse_input(input)

    rules
    |> Map.delete("shiny gold")
    |> Map.keys()
    |> Enum.map(&count_contains(&1, rules, "shiny gold"))
    |> Enum.count(&Function.identity/1)
  end

  def part2(input) do
    count_bags("shiny gold", parse_input(input)) - 1
  end

  def parse_input(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Map.new()
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
    rules
    |> Map.get(checking)
    |> Map.keys()
    |> Enum.map(&count_contains(&1, rules, expected))
    |> Enum.any?()
  end

  def count_bags(parent, rules) do
    count =
      rules
      |> Map.get(parent)
      |> Enum.map(fn {child, count} -> count * count_bags(child, rules) end)
      |> Enum.sum()

    count + 1
  end
end
