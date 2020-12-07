defmodule Aoc2020Day07Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day07

  @full_data File.read!("inputs/day07.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data File.read!("inputs/day07_example.txt")
                |> String.trim()
                |> String.split("\n")

  test "parse lines" do
    assert Day07.parse_line(Enum.at(@example_data, 0)) ==
             {"light red", %{"bright white" => 1, "muted yellow" => 2}}

    assert Day07.parse_line(Enum.at(@example_data, 2)) ==
             {"bright white", %{"shiny gold" => 1}}

    assert Day07.parse_line("dim brown bags contain no other bags.") == {"dim brown", %{}}
  end

  test "count contains" do
    rules = %{
      "bright white" => %{"shiny gold" => 1},
      "dark olive" => %{"dotted black" => 4, "faded blue" => 3},
      "dark orange" => %{"bright white" => 3, "muted yellow" => 4},
      "dotted black" => %{},
      "faded blue" => %{},
      "light red" => %{"bright white" => 1, "muted yellow" => 2},
      "muted yellow" => %{"faded blue" => 9, "shiny gold" => 2},
      "shiny gold" => %{"dark olive" => 1, "vibrant plum" => 2},
      "vibrant plum" => %{"dotted black" => 6, "faded blue" => 5}
    }

    assert Day07.count_contains("bright white", rules, "shiny gold")
    refute Day07.count_contains("dark olive", rules, "shiny gold")
    assert Day07.count_contains("dark orange", rules, "shiny gold")
    refute Day07.count_contains("dotted black", rules, "shiny gold")
    refute Day07.count_contains("faded blue", rules, "shiny gold")
    assert Day07.count_contains("light red", rules, "shiny gold")
    assert Day07.count_contains("muted yellow", rules, "shiny gold")
    refute Day07.count_contains("vibrant plum", rules, "shiny gold")
  end

  test "p1: default example" do
    assert Day07.part1(@example_data) == 4
  end

  test "p1: full" do
    assert Day07.part1(@full_data) == 101
  end

  @tag :skip
  test "p2: default example" do
    assert Day07.part2(@example_data) == 6
  end

  @tag :skip
  test "p2: full" do
    assert Day07.part2(@full_data) == 3276
  end
end
