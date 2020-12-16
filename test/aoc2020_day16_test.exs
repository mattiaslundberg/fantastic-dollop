defmodule Aoc2020Day16Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day16

  @full_data File.read!("inputs/day16.txt")
             |> String.trim()
             |> String.split("\n\n")

  @example_data File.read!("inputs/day16_example.txt")
                |> String.trim()
                |> String.split("\n\n")

  @example_data2 File.read!("inputs/day16_example2.txt")
                 |> String.trim()
                 |> String.split("\n\n")

  test "p1: default example" do
    assert Day16.part1(@example_data) == 71
  end

  test "p1: full" do
    assert Day16.part1(@full_data) == 21996
  end

  test "p2: default example" do
    assert Day16.part2(@example_data2) == 1
  end

  test "p2: full" do
    res = Day16.part2(@full_data)
    assert res > 668
    assert res == 650_080_463_519
  end
end
