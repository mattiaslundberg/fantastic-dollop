defmodule Aoc2020.Day05 do
  def part1(strs) do
    strs |> Enum.map(&find_seat/1) |> Enum.max()
  end

  def part2(strs) do
    seats = strs |> Enum.map(&find_seat/1) |> Enum.sort()

    Enum.reduce_while(seats, List.first(seats), fn s, last ->
      if last + 1 < s do
        {:halt, last + 1}
      else
        {:cont, s}
      end
    end)
  end

  def find_row(_, v, v), do: v
  def find_row("F" <> str, low, high), do: find_row(str, low, high - ceil((high - low) / 2))
  def find_row("B" <> str, low, high), do: find_row(str, low + ceil((high - low) / 2), high)

  def find_col(_, v, v), do: v
  def find_col("L" <> str, low, high), do: find_col(str, low, high - ceil((high - low) / 2))
  def find_col("R" <> str, low, high), do: find_col(str, low + ceil((high - low) / 2), high)

  def find_seat(str) do
    {row_desc, col_desc} = String.split_at(str, 7)
    row = find_row(row_desc, 0, 127)
    col = find_col(col_desc, 0, 7)

    row * 8 + col
  end
end
