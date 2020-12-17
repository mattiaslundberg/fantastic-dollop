defmodule Aoc2020Day17Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day17

  @full_data File.read!("inputs/day17.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    ".#.",
    "..#",
    "###"
  ]

  test "parse" do
    assert Day17.parse(@example_data) ==
             %{
               {0, 0, 0} => 0,
               {0, 1, 0} => 1,
               {0, 2, 0} => 0,
               {1, 0, 0} => 0,
               {1, 1, 0} => 0,
               {1, 2, 0} => 1,
               {2, 0, 0} => 1,
               {2, 1, 0} => 1,
               {2, 2, 0} => 1
             }
  end

  test "p1: default example" do
    assert Day17.part1(@example_data) == 112
  end

  test "p1: full" do
    res = Day17.part1(@full_data)
    assert res > 237
    assert res == 293
  end

  test "p2: one" do
    grid = @example_data |> Day17.parse2()
    one = Day17.run_cycle2(0, grid)
    assert Day17.count_active(one) == 29
    two = Day17.run_cycle2(0, one)
    assert Day17.count_active(two) == 60
  end

  @tag :skip
  test "p2: default example" do
    assert Day17.part2(@example_data) == 848
  end

  @tag :skip
  test "p2: full" do
    assert Day17.part2(@full_data) == 1816
  end
end
