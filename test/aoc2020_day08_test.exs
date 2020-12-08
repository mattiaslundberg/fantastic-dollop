defmodule Aoc2020Day08Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day08

  @full_data File.read!("inputs/day08.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data File.read!("inputs/day08_example.txt")
                |> String.trim()
                |> String.split("\n")

  test "p1: default example" do
    assert Day08.part1(@example_data) == 5
  end

  test "p1: full" do
    assert Day08.part1(@full_data) == 1797
  end

  test "p2: default example" do
    assert Day08.part2(@example_data) == 8
  end

  test "p2: full" do
    assert Day08.part2(@full_data) == 1036
  end
end
