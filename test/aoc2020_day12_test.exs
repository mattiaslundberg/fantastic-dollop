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

  test "2 move forward" do
    assert {10, 100, 1, 10} = Day12.move2({:forward, 10}, {0, 0, 1, 10})
    assert {38, 170, 4, 10} = Day12.move2({:forward, 7}, {10, 100, 4, 10})
  end

  test "2 move waypoint" do
    assert {_, _, 11, 10} = Day12.move2({:north, 10}, {0, 0, 1, 10})
    assert {_, _, 0, 10} = Day12.move2({:south, 4}, {10, 100, 4, 10})
    assert {_, _, 4, 14} = Day12.move2({:east, 4}, {10, 100, 4, 10})
    assert {_, _, 4, 6} = Day12.move2({:west, 4}, {10, 100, 4, 10})
  end

  test "2 rotate" do
    assert {38, 170, 10, -4} = Day12.move2({:left, 90}, {38, 170, 4, 10})
    assert {38, 170, -10, 4} = Day12.move2({:right, 90}, {38, 170, 4, 10})
    assert {38, 170, -4, -10} = Day12.move2({:right, 180}, {38, 170, 4, 10})
  end

  test "2 example steps" do
    assert {10, 100, 1, 10} = Day12.move2({:forward, 10}, {0, 0, 1, 10})
    assert {10, 100, 4, 10} = Day12.move2({:north, 3}, {10, 100, 1, 10})
    assert {38, 170, 4, 10} = Day12.move2({:forward, 7}, {10, 100, 4, 10})
    assert {38, 170, -10, 4} = Day12.move2({:right, 90}, {38, 170, 4, 10})
    assert {-72, 214, -10, 4} = Day12.move2({:forward, 11}, {38, 170, -10, 4})
  end

  test "p1: default example" do
    assert Day12.part1(@example_data) == 25
  end

  test "p1: full" do
    assert Day12.part1(@full_data) == 2847
  end

  test "p2: default example" do
    assert Day12.part2(@example_data) == 286
  end

  test "p2: full" do
    res = Day12.part2(@full_data)
    assert res > 16307
    assert res < 51849
    assert res == 29839
  end
end
