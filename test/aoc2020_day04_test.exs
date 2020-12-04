defmodule Aoc2020Day04Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day04

  @full_data File.read!("inputs/day04.txt")
             |> String.trim()
             |> String.split("\n\n")

  @example_data File.read!("inputs/day04_example.txt")
                |> String.trim()
                |> String.split("\n\n")

  test "p1: default example" do
    assert Day04.part1(@example_data) == 2
  end

  test "p1: full" do
    assert Day04.part1(@full_data) == 247
  end

  @tag :skip
  test "p2: default examples" do
    assert Day04.part2(@example_data) == 336
  end

  @tag :skip
  test "p2: full" do
    assert Day04.part2(@full_data) < 5_794_675_200
    assert Day04.part2(@full_data) == 2_655_892_800
  end
end
