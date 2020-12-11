defmodule Aoc2020.Day11 do
  @directions [[0, 1], [0, -1], [1, 0], [1, 1], [1, -1], [-1, 0], [-1, 1], [-1, -1]]

  def part1(input) do
    rows = length(input)
    cols = input |> Enum.at(0) |> String.length()

    input
    |> into_map()
    |> do_move(&count_neighbors/4, 4, rows, cols)
    |> Map.values()
    |> Enum.reduce(0, fn s, acc ->
      acc + (s |> String.graphemes() |> Enum.count(fn c -> c == "#" end))
    end)
  end

  def into_map(input) do
    chunk_size = input |> Enum.at(0) |> String.length()

    for c <- 0..(length(input) - 1), r <- 0..(chunk_size - 1) do
      val = input |> Enum.at(c, "") |> String.at(r)
      {{c, r}, val}
    end
    |> Map.new()
  end

  def part2(input) do
    :ok
    # input
    # |> do_move(&count_directions/4, 5)
    # |> Enum.reduce(0, fn s, acc ->
    #   acc + (s |> String.graphemes() |> Enum.count(fn c -> c == "#" end))
    # end)
  end

  def do_move(input, count_fn, max_neighs, cols, rows) do
    new_input =
      for c <- 0..(cols - 1), r <- 0..(rows - 1) do
        val =
          case get_elem(input, c, r) do
            "L" -> if count_fn.(input, c, r, 1) == 0, do: "#", else: "L"
            "#" -> if count_fn.(input, c, r, max_neighs) >= max_neighs, do: "L", else: "#"
            c -> c
          end

        {{c, r}, val}
      end
      |> Map.new()

    if input == new_input do
      input
    else
      do_move(new_input, count_fn, max_neighs, cols, rows)
    end
  end

  def count_directions(input, c, r, max) do
    @directions
    |> Enum.reduce_while(0, fn [dc, dr], acc ->
      new = acc + count_direction(input, c, r, dc, dr)

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  def count_direction(_input, _c, _r, 0, 0), do: 0

  def count_direction(input, c, r, dc, dr) do
    case get_elem(input, c, r) do
      "#" -> 1
      "L" -> 0
      "." -> count_direction(input, c + dc, r + dr, dc, dr)
      nil -> 0
    end
  end

  def count_neighbors(input, c, r, max) do
    @directions
    |> Enum.reduce_while(0, fn [dc, dr], acc ->
      new =
        acc +
          case get_elem(input, c + dc, r + dr) do
            "#" -> 1
            _ -> 0
          end

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  defp get_elem(input, col, row) do
    Map.get(input, {col, row})
  end
end
