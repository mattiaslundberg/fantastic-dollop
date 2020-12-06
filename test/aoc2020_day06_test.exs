defmodule Aoc2020Day06Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day06

  @full_data File.read!("inputs/day06.txt")
             |> String.trim()
             |> String.split("\n\n")
             |> Enum.map(&String.replace(&1, "\n", ""))

  @example_data File.read!("inputs/day06_example.txt")
                |> String.trim()
                |> String.split("\n\n")
                |> Enum.map(&String.replace(&1, "\n", ""))

  test "p1: default example" do
    assert Day06.part1(@example_data) == 11
  end

  test "p1: full" do
    assert Day06.part1(@full_data) == 6585
  end

  @tag :skip
  test "p2: default example" do
    assert Day06.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day06.part2(@full_data) == :ok
  end
end
