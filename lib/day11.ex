defmodule Aoc2020.Day11 do
  @directions [[0, 1], [0, -1], [1, 0], [1, 1], [1, -1], [-1, 0], [-1, 1], [-1, -1]]

  def part1(input) do
    rows = length(input)
    cols = input |> Enum.at(0) |> String.length()

    input
    |> into_map()
    |> do_move(&count_neighbors/4, 4, rows, cols)
    |> count_occupied()
  end

  def part2(input) do
    rows = length(input)
    cols = input |> Enum.at(0) |> String.length()

    input
    |> into_map()
    |> do_move(&count_directions/4, 5, rows, cols)
    |> count_occupied()
  end

  defp count_occupied(map) do
    map
    |> Map.values()
    |> Enum.reduce(0, fn s, acc ->
      acc + if s == :occupied, do: 1, else: 0
    end)
  end

  def into_map(input) do
    chunk_size = input |> Enum.at(0) |> String.length()

    for c <- 0..(length(input) - 1), r <- 0..(chunk_size - 1) do
      val =
        case input |> Enum.at(c, "") |> String.at(r) do
          "#" -> :occupied
          "L" -> :free
          "." -> :floor
        end

      {{c, r}, val}
    end
    |> Map.new()
  end

  def do_move(input, count_fn, max_neighs, cols, rows) do
    new_input =
      for c <- 0..(cols - 1), r <- 0..(rows - 1) do
        val =
          case Map.get(input, {c, r}) do
            :free ->
              if count_fn.(input, c, r, 1) == 0, do: :occupied, else: :free

            :occupied ->
              if count_fn.(input, c, r, max_neighs) >= max_neighs, do: :free, else: :occupied

            v ->
              v
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
    Enum.reduce_while(@directions, 0, fn [dc, dr], acc ->
      new = acc + count_direction(input, c + dc, r + dr, dc, dr)

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  def count_direction(input, c, r, dc, dr) do
    case Map.get(input, {c, r}) do
      :occupied -> 1
      :free -> 0
      :floor -> count_direction(input, c + dc, r + dr, dc, dr)
      nil -> 0
    end
  end

  def count_neighbors(input, c, r, max) do
    Enum.reduce_while(@directions, 0, fn [dc, dr], acc ->
      new =
        acc +
          case Map.get(input, {c + dc, r + dr}) do
            :occupied -> 1
            _ -> 0
          end

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end
end
