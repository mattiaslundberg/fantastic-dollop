defmodule Aoc2020Day09Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day09

  @full_data File.read!("inputs/day09.txt")
             |> String.trim()
             |> String.split("\n")
             |> Enum.map(&String.to_integer/1)

  @example_data File.read!("inputs/day09_example.txt")
                |> String.trim()
                |> String.split("\n")
                |> Enum.map(&String.to_integer/1)

  test "check list" do
    assert Day09.check_list([1, 1], [1]) == [false]
    assert Day09.check_list([1, 9], [1]) == [false]
    assert Day09.check_list([1, 9], [1]) == [false]
    assert Day09.check_list([1, 3], [4]) == [true]
    assert Day09.check_list([1, 2, 3, 4, 5], [1, 5, 3]) == [false, true, false]
  end

  test "p1: default example" do
    assert Day09.part1(@example_data, 5) == 127
  end

  test "p1: full" do
    assert Day09.part1(@full_data, 25) == 1_124_361_034
  end

  test "find_sum" do
    assert Day09.find_sum(0, [1, 2, 2, 9, 4], 5, []) == 3
    assert Day09.find_sum(0, [3, 4, 9, 2], 18, []) == 11
    assert Day09.find_sum(0, [4, 3, 9, 2], 18, []) == 11
  end

  test "p2: default example" do
    assert Day09.part2(@example_data, 127) == 62
  end

  test "p2: full" do
    res = Day09.part2(@full_data, 1_124_361_034)
    assert res > 122_438_900
    assert res != 2_429_079_910
    assert res == 129_444_555
  end
end
