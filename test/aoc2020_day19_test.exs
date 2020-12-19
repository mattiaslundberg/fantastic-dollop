defmodule Aoc2020Day19Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day19

  @full_data File.read!("inputs/day19.txt")
             |> String.trim()
             |> String.split("\n\n")

  @example_data File.read!("inputs/day19_example.txt")
                |> String.trim()
                |> String.split("\n\n")

  @example_2 File.read!("inputs/day19_example2.txt")
             |> String.trim()
             |> String.split("\n\n")

  test "parse rules" do
    assert Day19.parse_rules(Enum.at(@example_data, 0)) == %{
             0 => [4, 1, 5],
             1 => [[2, 3], [3, 2]],
             2 => [[4, 4], [5, 5]],
             3 => [[4, 5], [5, 4]],
             4 => "a",
             5 => "b"
           }

    assert Day19.parse_rules(Enum.at(@full_data, 0)) != %{}
  end

  test "new" do
    assert Day19.matches_rule(%{0 => "a"}, ["a"], 0) == {true, []}
    assert Day19.matches_rule(%{0 => "a"}, ["a", "b"], 0) == {true, ["b"]}
    assert Day19.matches_rule(%{0 => "a"}, [], 0) == {false, []}

    assert Day19.matches_rule(%{0 => [1, 2], 1 => "a", 2 => "b"}, ["a", "b"], 0) == {true, []}
    assert Day19.matches_rule(%{0 => [1, 2], 1 => "a", 2 => "b"}, ["a"], 0) == {false, []}

    assert Day19.matches_rule(%{0 => [1, 2], 1 => "a", 2 => "b"}, ["a", "b", "a"], 0) ==
             {true, ["a"]}

    assert Day19.matches_rule(%{0 => [1, 3], 1 => "a", 2 => "b", 3 => [2]}, ["a", "b"], 0) ==
             {true, []}
  end

  test "matches rule" do
    assert Day19.matches_rule(
             %{0 => [[1, 2], [2, 1]], 1 => "a", 2 => "b"},
             ["a", "b"],
             0
           ) == {true, []}

    assert Day19.matches_rule(
             %{0 => [[1, 2], [2, 1]], 1 => "a", 2 => "b"},
             ["a", "b", "a"],
             0
           ) == {true, ["a"]}

    assert Day19.matches_rule(
             %{0 => [[1, 2], [2, 1]], 1 => "a", 2 => "b"},
             ["b", "a"],
             0
           ) == {true, []}
  end

  test "p1: default example" do
    assert Day19.part1(@example_data) == 2
  end

  test "p1: default example 2" do
    assert Day19.part1(@example_2) == 3
  end

  test "p1: full" do
    res = Day19.part1(@full_data)
    assert res == 142
  end

  test "p2: default example" do
    assert Day19.part2(@example_2) == 12
  end

  @tag :skip
  test "p2: full" do
    assert Day19.part2(@full_data) == :ok
  end
end
