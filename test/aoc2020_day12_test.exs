defmodule Aoc2020Day12Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day12

  @full_data File.read!("inputs/day12.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    "F10",
    "N3",
    "F7",
    "R90",
    "F11"
  ]

  test "rotate right" do
    assert {_, _, :south} = Day12.move({:right, 90}, {0, 0, :east})
    assert {_, _, :west} = Day12.move({:right, 180}, {0, 0, :east})
    assert {_, _, :north} = Day12.move({:right, 270}, {0, 0, :east})
    assert {_, _, :east} = Day12.move({:right, 90}, {0, 0, :north})
    assert {_, _, :south} = Day12.move({:right, 180}, {0, 0, :north})
    assert {_, _, :west} = Day12.move({:right, 270}, {0, 0, :north})
  end

  test "rotate left" do
    assert {_, _, :north} = Day12.move({:left, 90}, {0, 0, :east})
    assert {_, _, :west} = Day12.move({:left, 180}, {0, 0, :east})
    assert {_, _, :south} = Day12.move({:left, 270}, {0, 0, :east})
    assert {_, _, :west} = Day12.move({:left, 90}, {0, 0, :north})
    assert {_, _, :south} = Day12.move({:left, 180}, {0, 0, :north})
    assert {_, _, :east} = Day12.move({:left, 270}, {0, 0, :north})
  end

  test "p1: default example" do
    assert Day12.part1(@example_data) == 25
  end

  test "p1: full" do
    assert Day12.part1(@full_data) == 2847
  end

  @tag :skip
  test "p2: default example" do
    assert Day12.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day12.part2(@full_data) == :ok
  end
end
