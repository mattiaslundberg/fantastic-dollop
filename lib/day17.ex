defmodule Aoc2020.Day17 do
  alias Aoc2020.Day17Dimensions
  @size 12

  def part1(input) do
    grid = parse(input)

    0..5
    |> Enum.reduce(grid, &run_cycle/2)
    |> count_active()
  end

  def part2(input) do
    grid = parse2(input)

    0..5
    |> Enum.reduce(grid, &run_cycle2/2)
    |> count_active()
  end

  def run_cycle(_, grid) do
    for x <- -@size..@size, y <- -@size..@size, z <- -@size..@size do
      update_cell(grid, x, y, z)
    end
    |> Enum.filter(&Function.identity/1)
    |> Map.new()
  end

  def update_cell(grid, x, y, z) do
    this_v = Map.get(grid, {x, y, z}, 0)

    case {this_v, count_neighbours(grid, x, y, z, 4)} do
      {0, 3} -> {{x, y, z}, 1}
      {1, 2} -> {{x, y, z}, 1}
      {1, 3} -> {{x, y, z}, 1}
      _ -> nil
    end
  end

  def count_neighbours(grid, x, y, z, max) do
    Enum.reduce_while(Day17Dimensions.three(), 0, fn [dx, dy, dz], acc ->
      new = acc + Map.get(grid, {x + dx, y + dy, z + dz}, 0)

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  def run_cycle2(_, grid) do
    for x <- -@size..@size, y <- -@size..@size, z <- -@size..@size, w <- -@size..@size do
      update_cell(grid, x, y, z, w)
    end
    |> Enum.filter(&Function.identity/1)
    |> Map.new()
  end

  def update_cell(grid, x, y, z, w) do
    this_v = Map.get(grid, {x, y, z, w}, 0)

    case {this_v, count_neighbours(grid, x, y, z, w, 4)} do
      {0, 3} -> {{x, y, z, w}, 1}
      {1, 2} -> {{x, y, z, w}, 1}
      {1, 3} -> {{x, y, z, w}, 1}
      _ -> nil
    end
  end

  def count_neighbours(grid, x, y, z, w, max) do
    Enum.reduce_while(Day17Dimensions.four(), 0, fn [dx, dy, dz, dw], acc ->
      new = acc + Map.get(grid, {x + dx, y + dy, z + dz, w + dw}, 0)

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  def count_active(grid) do
    grid |> Map.values() |> Enum.sum()
  end

  def parse(input) do
    for x <- 0..(length(input) - 1), y <- 0..(String.length(Enum.at(input, 0)) - 1) do
      {{x, y, 0}, input |> Enum.at(x) |> String.at(y) |> as_int()}
    end
    |> Map.new()
  end

  def parse2(input) do
    for x <- 0..(length(input) - 1), y <- 0..(String.length(Enum.at(input, 0)) - 1) do
      {{x, y, 0, 0}, input |> Enum.at(x) |> String.at(y) |> as_int()}
    end
    |> Map.new()
  end

  defp as_int("."), do: 0
  defp as_int("#"), do: 1
end
