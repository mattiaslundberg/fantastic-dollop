defmodule Aoc2020Day01Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day01

  @full_data File.read!("inputs/day01.txt")
             |> String.trim()
             |> String.split("\n")
             |> Enum.map(&String.to_integer/1)

  @example_data [
    1721,
    979,
    366,
    299,
    675,
    1456
  ]

  test "find pair with sum" do
    assert Day01.find_with_sum([100, 200, 10, 20], 110) == [100, 10]
    assert Day01.find_with_sum([100, 200, 10, 20], 130, 3) == [100, 10, 20]
    assert Day01.find_with_sum(@example_data, 2020) == [1721, 299]
  end

  test "p1: default examples" do
    assert Aoc2020.Day01.part1(@example_data) == 514_579
  end

  test "p1: full" do
    assert Aoc2020.Day01.part1(@full_data) == 731_731
  end

  test "p2: default examples" do
    assert Day01.part2(@example_data) == 241_861_950
  end

  test "p2: full" do
    assert Day01.part2(@full_data) == 116_115_990
  end
end
