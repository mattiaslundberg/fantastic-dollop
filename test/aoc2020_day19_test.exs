defmodule Aoc2020Day19Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day19

  @full_data File.read!("inputs/day19.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data []

  @tag :skip
  test "p1: default example" do
    assert Day19.part1(@example_data) == :ok
  end

  @tag :skip
  test "p1: full" do
    assert Day19.part1(@full_data) == :ok
  end

  @tag :skip
  test "p2: default example" do
    assert Day19.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day19.part2(@full_data) == :ok
  end
end
