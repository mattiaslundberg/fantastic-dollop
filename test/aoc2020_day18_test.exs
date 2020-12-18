defmodule Aoc2020Day18Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day18

  @full_data File.read!("inputs/day18.txt")
             |> String.trim()
             |> String.split("\n")

  test "p1: default example" do
    assert Day18.part1("1 * 2 + 3") == 5
    assert Day18.part1("1 + 2 * 3 + 4 * 5 + 6") == 71
    assert Day18.part1("1 + (2 + 3)") == 6
    assert Day18.part1("1 * (2 + 3)") == 5
    assert Day18.part1("2 * 3 + (4 * 5)") == 26
    assert Day18.part1("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    assert Day18.part1("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
    assert Day18.part1("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
    assert Day18.part1(["1 + 2 * 3 + 4 * 5 + 6", "2 * 3 + (4 * 5)"]) == 71 + 26
    assert Day18.part1("1 + (2 * 3) + (4 * (5 + 6))") == 51
  end

  test "p1: full" do
    assert Day18.part1(@full_data) == 69_490_582_260
  end

  test "p2: default example" do
    assert Day18.part2("1 + 2 * 3 + 4 * 5 + 6") == 231
    assert Day18.part2("1 + (2 * 3) + (4 * (5 + 6))") == 51
    assert Day18.part2("2 * 3 + (4 * 5)") == 46
    assert Day18.part2("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
    assert Day18.part2("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 669_060
    assert Day18.part2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
    assert Day18.part2(["1 + 2 * 3 + 4 * 5 + 6", "2 * 3 + (4 * 5)"]) == 231 + 46
  end

  test "p2: full" do
    assert Day18.part2(@full_data) == 362_464_596_624_526
  end
end
