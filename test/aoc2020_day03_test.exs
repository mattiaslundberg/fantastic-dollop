defmodule Aoc2020Day03Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day03

  @full_data File.read!("inputs/day03.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data File.read!("inputs/day03_example.txt")
                |> String.trim()
                |> String.split("\n")

  test "p1: default example" do
    assert Day03.part1(@example_data) == 7
  end

  test "p1: full" do
    assert Day03.part1(@full_data) == 207
  end

  test "for specific slopes" do
    assert Day03.get_for_slope(@example_data, 1, 1) == 2
    assert Day03.get_for_slope(@example_data, 3, 1) == 7
    assert Day03.get_for_slope(@example_data, 5, 1) == 3
    assert Day03.get_for_slope(@example_data, 7, 1) == 4
    assert Day03.get_for_slope(@example_data, 1, 2) == 2
  end

  test "p2: default examples" do
    assert Day03.part2(@example_data) == 336
  end

  test "p2: full" do
    assert Day03.part2(@full_data) < 5_794_675_200
    assert Day03.part2(@full_data) == 2_655_892_800
  end
end
