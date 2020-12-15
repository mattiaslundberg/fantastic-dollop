defmodule Aoc2020Day15Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day15

  @full_data [0, 5, 4, 1, 10, 14, 7]

  test "get number to say" do
    assert Day15.get_number_to_say(4, [6, 3, 0]) == 0
    assert Day15.get_number_to_say(5, [0, 6, 3, 0]) == 3
    assert Day15.get_number_to_say(6, [3, 0, 6, 3, 0]) == 3
    assert Day15.get_number_to_say(7, [3, 3, 0, 6, 3, 0]) == 1
    assert Day15.get_number_to_say(8, [1, 3, 3, 0, 6, 3, 0]) == 0
    assert Day15.get_number_to_say(9, [0, 1, 3, 3, 0, 6, 3, 0]) == 4
    assert Day15.get_number_to_say(10, [4, 0, 1, 3, 3, 0, 6, 3, 0]) == 0
  end

  test "p1: default examples" do
    assert Day15.part1([0, 3, 6]) == 436
    assert Day15.part1([1, 3, 2]) == 1
    assert Day15.part1([2, 1, 3]) == 10
    assert Day15.part1([1, 2, 3]) == 27
    assert Day15.part1([2, 3, 1]) == 78
    assert Day15.part1([3, 2, 1]) == 438
    assert Day15.part1([3, 1, 2]) == 1836
  end

  test "p1: full" do
    assert Day15.part1(@full_data) == 203
  end

  @tag :skip
  test "p2: default example" do
    # assert Day15.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day15.part2(@full_data) == :ok
  end
end
