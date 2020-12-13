defmodule Aoc2020Day13Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day13

  @full_data File.read!("inputs/day13.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data [
    "939",
    "7,13,x,x,59,x,31,19"
  ]

  test "parse" do
    assert [939, [7, 13, 59, 31, 19]] = Day13.parse(@example_data)
  end

  test "best for bus" do
    assert Day13.best_for_bus(939, 7) == {7, 6}
    assert Day13.best_for_bus(939, 13) == {13, 10}
    assert Day13.best_for_bus(939, 59) == {59, 5}
  end

  test "p1: default example" do
    assert Day13.part1(@example_data) == 295
  end

  test "p1: full" do
    assert Day13.part1(@full_data) == 3606
  end

  @tag :skip
  test "p2: default example" do
    assert Day13.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day13.part2(@full_data) == :ok
  end
end
