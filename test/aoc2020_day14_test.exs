defmodule Aoc2020Day14Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day14

  @full_data File.read!("inputs/day14.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
    "mem[8] = 11",
    "mem[7] = 101",
    "mem[8] = 0"
  ]

  test "parse" do
    assert Day14.parse("mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X") ==
             [:mask, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"]

    assert Day14.parse("mem[8] = 11") == [8, "000000000000000000000000000000001011"]
    assert Day14.parse("mem[8888] = 11") == [8888, "000000000000000000000000000000001011"]
  end

  test "apply mask" do
    mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"

    assert Day14.apply_mask(mask, "000000000000000000000000000000001011") ==
             "000000000000000000000000000001001001"
  end

  test "p1: default example" do
    assert Day14.part1(@example_data) == 165
  end

  test "p1: full" do
    assert Day14.part1(@full_data) == 13_476_250_121_721
  end

  @tag :skip
  test "p2: default example" do
    assert Day14.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day14.part2(@full_data) == :ok
  end
end
