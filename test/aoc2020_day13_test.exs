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
    assert [939, [7, 13, 1, 1, 59, 1, 31, 19]] = Day13.parse(@example_data)
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

  test "p2: default example" do
    assert Day13.part2(@example_data) == 1_068_781
  end

  test "extra example 1" do
    assert Day13.part2(["1", "17,x,13,19"]) == 3417
  end

  test "extra example 2" do
    assert Day13.part2(["1", "67,7,59,61"]) == 754_018
  end

  test "extra example 3" do
    assert Day13.part2(["1", "67,x,7,59,61"]) == 779_210
  end

  test "extra example 4" do
    assert Day13.part2(["1", "67,7,x,59,61"]) == 1_261_476
  end

  test "extra example 5" do
    assert Day13.part2(["1", "1789,37,47,1889"]) == 1_202_161_486
  end

  test "p2: full" do
    assert Day13.part2(@full_data) == 379_786_358_533_423
  end
end
