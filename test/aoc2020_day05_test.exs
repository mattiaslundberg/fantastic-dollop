defmodule Aoc2020Day05Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day05

  @full_data File.read!("inputs/day05.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    "FBFBBFFRLR",
    "BFFFBBFRRR",
    "FFFBBBFRRR",
    "BBFFBBFRLL"
  ]

  test "finding rows" do
    assert Day05.find_row("FBFBBFFRLR", 0, 127) == 44
    assert Day05.find_row("BFFFBBFRRR", 0, 127) == 70
    assert Day05.find_row("FFFBBBFRRR", 0, 127) == 14
    assert Day05.find_row("BBFFBBFRLL", 0, 127) == 102
  end

  test "finding columns" do
    assert Day05.find_col("RLR", 0, 7) == 5
    assert Day05.find_col("RRR", 0, 7) == 7
    assert Day05.find_col("RLL", 0, 7) == 4
  end

  test "finding seat id" do
    assert Day05.find_seat("FBFBBFFRLR") == 357
    assert Day05.find_seat("BFFFBBFRRR") == 567
    assert Day05.find_seat("FFFBBBFRRR") == 119
    assert Day05.find_seat("BBFFBBFRLL") == 820
  end

  test "p1: default example" do
    assert Day05.part1(@example_data) == 820
  end

  test "p1: full" do
    assert Day05.part1(@full_data) == 806
  end

  test "p2: full" do
    assert Day05.part2(@full_data) == 562
  end
end
