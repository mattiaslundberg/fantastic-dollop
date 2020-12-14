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

  @example_2 [
    "mask = 000000000000000000000000000000X1001X",
    "mem[42] = 100",
    "mask = 00000000000000000000000000000000X0XX",
    "mem[26] = 1"
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

  test "get addresses" do
    assert Day14.get_addresses("000", "111") == ["111"]
    assert Day14.get_addresses("111", "000") == ["111"]
    assert Day14.get_addresses("X11", "111") == ["111", "011"]
    assert Day14.get_addresses("01X", "111") == ["111", "110"]

    assert Day14.get_addresses("0XX", "111") |> Enum.sort() ==
             ["111", "110", "101", "100"] |> Enum.sort()

    assert Day14.get_addresses(
             "000000000000000000000000000000X1001X",
             "000000000000000000000000000000101010"
           )
           |> Enum.map(&String.to_integer(&1, 2))
           |> Enum.sort() ==
             [26, 27, 58, 59]

    assert Day14.get_addresses(
             "00000000000000000000000000000000X0XX",
             "000000000000000000000000000000011010"
           )
           |> Enum.map(&String.to_integer(&1, 2))
           |> Enum.sort() ==
             [16, 17, 18, 19, 24, 25, 26, 27]
  end

  test "p2: default example" do
    assert Day14.part2(@example_2) == 208
  end

  test "p2: full" do
    assert Day14.part2(@full_data) == 4_463_708_436_768
  end
end
