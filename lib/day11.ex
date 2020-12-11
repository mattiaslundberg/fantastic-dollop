defmodule Aoc2020.Day11 do
  @directions [[0, 1], [0, -1], [1, 0], [1, 1], [1, -1], [-1, 0], [-1, 1], [-1, -1]]

  def part1(input), do: run(input, &count_neighbors/4, 4)

  def part2(input), do: run(input, &count_directions/4, 5)

  defp run(input, count_fn, max) do
    rows = length(input)
    cols = input |> Enum.at(0) |> String.length()

    input
    |> transform(cols)
    |> do_move(count_fn, max, rows, cols)
    |> count_occupied()
  end

  def transform(input, cols) do
    for c <- 0..(length(input) - 1), r <- 0..(cols - 1) do
      {{c, r}, transform_char(input |> Enum.at(c, "") |> String.at(r))}
    end
    |> Map.new()
  end

  defp transform_char("#"), do: :occupied
  defp transform_char("L"), do: :free
  defp transform_char("."), do: :floor

  def do_move(seats, count_fn, max_neighs, cols, rows) do
    new_seats = generate_seats(seats, count_fn, max_neighs, cols, rows)

    if seats == new_seats do
      seats
    else
      do_move(new_seats, count_fn, max_neighs, cols, rows)
    end
  end

  def generate_seats(seats, count_fn, max_neighs, cols, rows) do
    for c <- 0..(cols - 1), r <- 0..(rows - 1) do
      val =
        case Map.get(seats, {c, r}) do
          :free ->
            if count_fn.(seats, c, r, 1) == 0, do: :occupied, else: :free

          :occupied ->
            if count_fn.(seats, c, r, max_neighs) >= max_neighs, do: :free, else: :occupied

          v ->
            v
        end

      {{c, r}, val}
    end
    |> Map.new()
  end

  def count_directions(seats, c, r, max) do
    Enum.reduce_while(@directions, 0, fn [dc, dr], acc ->
      new = acc + count_direction(seats, c + dc, r + dr, dc, dr)

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  def count_direction(seats, c, r, dc, dr) do
    case Map.get(seats, {c, r}) do
      :occupied -> 1
      :free -> 0
      :floor -> count_direction(seats, c + dc, r + dr, dc, dr)
      nil -> 0
    end
  end

  def count_neighbors(seats, c, r, max) do
    Enum.reduce_while(@directions, 0, fn [dc, dr], acc ->
      new =
        case Map.get(seats, {c + dc, r + dr}) do
          :occupied -> acc + 1
          _ -> acc
        end

      if new >= max do
        {:halt, new}
      else
        {:cont, new}
      end
    end)
  end

  defp count_occupied(map) do
    map
    |> Map.values()
    |> Enum.reduce(0, fn s, acc ->
      acc + if s == :occupied, do: 1, else: 0
    end)
  end
end
