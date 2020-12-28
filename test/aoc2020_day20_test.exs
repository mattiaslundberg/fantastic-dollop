defmodule Aoc2020Day20Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day20

  @full_data File.read!("inputs/day20.txt")
             |> String.trim()
             |> String.split("\n\n")

  @example_data File.read!("inputs/day20_example.txt")
                |> String.trim()
                |> String.split("\n\n")

  test "place tile down" do
    new = {:n, [[".", "#"], [".", "."]], [nil, nil, nil, nil]}
    old = {:o, [[".", "."], [".", "#"]], [nil, nil, nil, nil]}
    assert {true, {:o, _, [nil, new, nil, nil]}} = Day20.place_tile(new, old)
  end

  test "place tile up" do
    new = {:n, [[".", "*"], [".", "#"]], [nil, nil, nil, nil]}
    old = {:o, [[".", "#"], [".", "."]], [nil, nil, nil, nil]}
    assert {true, {:o, _, [nil, nil, nil, new]}} = Day20.place_tile(new, old)
  end

  test "place tile right" do
    new = {:n, [["*", "."], ["#", "."]], [nil, nil, nil, nil]}
    old = {:o, [[".", "*"], ["-", "#"]], [nil, nil, nil, nil]}
    assert {true, {:o, _, [new, nil, nil, nil]}} = Day20.place_tile(new, old)
  end

  test "place tile left" do
    new = {:n, [[".", "*"], ["-", "#"]], [nil, nil, nil, nil]}
    old = {:o, [["*", "."], ["#", "."]], [nil, nil, nil, nil]}
    assert {true, {:o, _, [nil, nil, new, nil]}} = Day20.place_tile(new, old)
  end

  @tag :skip
  test "p1: default example" do
    assert Day20.part1(@example_data) == :ok
  end

  @tag :skip
  test "p1: full" do
    assert Day20.part1(@full_data) == :ok
  end

  @tag :skip
  test "p2: default example" do
    assert Day20.part2(@example_data) == :ok
  end

  @tag :skip
  test "p2: full" do
    assert Day20.part2(@full_data) == :ok
  end
end
