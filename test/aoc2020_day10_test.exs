defmodule Aoc2020Day10Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day10

  @full_data File.read!("inputs/day10.txt")
             |> String.trim()
             |> String.split("\n")
             |> Enum.map(&String.to_integer/1)

  @example_data1 File.read!("inputs/day10_example1.txt")
                 |> String.trim()
                 |> String.split("\n")
                 |> Enum.map(&String.to_integer/1)

  @example_data2 File.read!("inputs/day10_example2.txt")
                 |> String.trim()
                 |> String.split("\n")
                 |> Enum.map(&String.to_integer/1)

  test "expected output" do
    assert Day10.expected_output(@example_data1) == 22
    assert Day10.expected_output(@example_data2) == 52
  end

  test "p1: default example 1" do
    assert Day10.part1(@example_data1) == 35
  end

  test "p1: default example 2" do
    assert Day10.part1(@example_data2) == 220
  end

  test "p1: full" do
    assert Day10.part1(@full_data) == 1848
  end

  test "p2: default example 1" do
    assert Day10.part2(@example_data1) == 8
  end

  test "p2: default example 2" do
    assert Day10.part2(@example_data2) == 19208
  end

  @tag :skip
  test "p2: full" do
    assert Day10.part2(@full_data) == :ok
  end
end
