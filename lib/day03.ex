defmodule Aoc2020.Day03 do
  def part1(input) do
    get_for_slope(input, 3, 1)
  end

  def part2(input) do
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    |> Enum.map(fn [right, down] -> get_for_slope(input, right, down) end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def get_for_slope(input, right, down) do
    input
    |> Enum.reduce({0, right, 0}, &update_total_with_line(right, down, &1, &2))
    |> elem(0)
  end

  defp update_total_with_line(_right, down, _x, {total, x_location, y_location})
       when y_location < down or rem(y_location, down) != 0,
       do: {total, x_location, y_location + 1}

  defp update_total_with_line(right, _down, x, {total, x_location, y_location}),
    do: {get_new_total(x, x_location, total), x_location + right, y_location + 1}

  defp get_new_total(x, location, total) do
    if String.at(x, rem(location, String.length(x))) == "#" do
      total + 1
    else
      total
    end
  end
end
