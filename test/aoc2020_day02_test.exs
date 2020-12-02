defmodule Aoc2020Day02Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day02

  @full_data File.read!("inputs/day02.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    "1-3 a: abcde",
    "1-3 b: cdefg",
    "2-9 c: ccccccccc"
  ]

  test "contains" do
    assert Day02.contains("a", "abcabc") == 2
    assert Day02.contains("x", "abcabc") == 0
    assert Day02.contains("c", "abcabc") == 2
    assert Day02.contains("c", "ababc") == 1
  end

  test "valid" do
    assert Day02.valid?(1, 2, "a", "abcabc")
    assert Day02.valid?(1, 2, "a", "abc")
    refute Day02.valid?(1, 2, "a", "bc")
    refute Day02.valid?(1, 2, "a", "aaabc")
  end

  test "parse line" do
    assert Day02.parse_line("1-3 a: abcde") == {1, 3, "a", "abcde"}
  end

  test "p1: default example" do
    assert Day02.part1(@example_data) == 2
  end

  test "p1: full" do
    assert Day02.part1(@full_data) == 447
  end

  test "valid_pos" do
    assert Day02.valid_pos?(1, 2, "a", "abc")
    assert Day02.valid_pos?(1, 2, "a", "bac")
    refute Day02.valid_pos?(1, 2, "a", "bca")
    refute Day02.valid_pos?(2, 3, "a", "abc")
    refute Day02.valid_pos?(1, 2, "a", "aac")

    refute Day02.valid_pos?(2, 4, "a", "aacax")
    assert Day02.valid_pos?(2, 4, "a", "aacxx")
  end

  test "p2: default examples" do
    assert Day02.part2(@example_data) == 1
  end

  test "p2: full" do
    assert Day02.part2(@full_data) != 445
    assert Day02.part2(@full_data) < 445
    assert Day02.part2(@full_data) == 249
  end
end
