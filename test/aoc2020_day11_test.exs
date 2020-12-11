defmodule Aoc2020Day11Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day11

  @full_data File.read!("inputs/day11.txt")
             |> String.trim()
             |> String.split("\n")

  @example_data File.read!("inputs/day11_example.txt")
                |> String.trim()
                |> String.split("\n")

  test "count neighbors" do
    input =
      [
        "#.#",
        ".##",
        "#.#"
      ]
      |> Day11.into_map()

    assert Day11.count_neighbors(input, 0, 0, 10) == 1
    assert Day11.count_neighbors(input, 1, 0, 10) == 3
    assert Day11.count_neighbors(input, 2, 1, 10) == 4
    assert Day11.count_neighbors(input, 2, 2, 10) == 2
  end

  test "count neighbors 2" do
    input =
      [
        "#.##",
        ".##.",
        "#.#."
      ]
      |> Day11.into_map()

    assert Day11.count_neighbors(input, 0, 0, 10) == 1
    assert Day11.count_neighbors(input, 0, 3, 10) == 2
    assert Day11.count_neighbors(input, 2, 3, 10) == 2
  end

  @tag :skip
  test "count directions" do
    input = [
      "#.#",
      ".##",
      "#.#"
    ]

    assert Day11.count_directions(input, 1, 1, 5) == 5
    assert Day11.count_directions(input, 1, 1, 3) == 3
  end

  test "minimal example" do
    assert Day11.part1([".L.", "..."]) == 1
  end

  test "p1: default example" do
    assert Day11.part1(@example_data) == 37
  end

  test "p1: full" do
    assert Day11.part1(@full_data) == 2289
  end

  @tag :skip
  test "p2: default example" do
    assert Day11.part2(@example_data) == 26
  end

  @tag :skip
  test "p2: full" do
    assert Day11.part2(@full_data) == :ok
  end
end
