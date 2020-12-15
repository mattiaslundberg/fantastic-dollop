defmodule Aoc2020Day15Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day15

  @full_data [0, 5, 4, 1, 10, 14, 7]

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
    assert Day15.part2([0, 3, 6]) == 175_594
    assert Day15.part2([1, 3, 2]) == 2578
    assert Day15.part2([2, 1, 3]) == 3_544_142
    assert Day15.part2([1, 2, 3]) == 261_214
    assert Day15.part2([2, 3, 1]) == 6_895_259
    assert Day15.part2([3, 2, 1]) == 18
    assert Day15.part2([3, 1, 2]) == 362
  end

  @tag :skip
  test "p2: full" do
    assert Day15.part2(@full_data) == 9_007_186
  end
end
