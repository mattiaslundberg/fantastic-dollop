defmodule Aoc2020.Day12 do
  @directions [:east, :south, :west, :north]
  def part1(input) do
    {a, b, _} = input |> Enum.map(&transform/1) |> Enum.reduce({0, 0, :east}, &move/2)
    abs(a) + abs(b)
  end

  def part2(input) do
    {a, b, _, _} = input |> Enum.map(&transform/1) |> Enum.reduce({0, 0, 1, 10}, &move2/2)
    abs(a) + abs(b)
  end

  def transform("F" <> num), do: {:forward, String.to_integer(num)}
  def transform("R" <> num), do: {:right, String.to_integer(num)}
  def transform("L" <> num), do: {:left, String.to_integer(num)}
  def transform("N" <> num), do: {:north, String.to_integer(num)}
  def transform("E" <> num), do: {:east, String.to_integer(num)}
  def transform("S" <> num), do: {:south, String.to_integer(num)}
  def transform("W" <> num), do: {:west, String.to_integer(num)}

  def move2({:forward, amount}, {a, b, wa, wb}), do: {a + amount * wa, b + amount * wb, wa, wb}
  def move2({:right, amount}, {a, b, wa, wb}), do: rotate2(amount, a, b, wa, wb)
  def move2({:left, amount}, {a, b, wa, wb}), do: rotate2(360 - amount, a, b, wa, wb)
  def move2({:north, amount}, {a, b, wa, wb}), do: {a, b, wa + amount, wb}
  def move2({:south, amount}, {a, b, wa, wb}), do: {a, b, wa - amount, wb}
  def move2({:east, amount}, {a, b, wa, wb}), do: {a, b, wa, wb + amount}
  def move2({:west, amount}, {a, b, wa, wb}), do: {a, b, wa, wb - amount}

  defp rotate2(90, a, b, wa, wb), do: {a, b, -wb, wa}
  defp rotate2(180, a, b, wa, wb), do: {a, b, -wa, -wb}
  defp rotate2(270, a, b, wa, wb), do: {a, b, wb, -wa}

  def move({:forward, amount}, {a, b, :east}), do: {a, b + amount, :east}
  def move({:forward, amount}, {a, b, :north}), do: {a + amount, b, :north}
  def move({:forward, amount}, {a, b, :south}), do: {a - amount, b, :south}
  def move({:forward, amount}, {a, b, :west}), do: {a, b - amount, :west}
  def move({:right, amount}, {a, b, direction}), do: rotate(amount, a, b, direction)
  def move({:left, amount}, {a, b, direction}), do: rotate(360 - amount, a, b, direction)
  def move({:north, amount}, {a, b, direction}), do: {a + amount, b, direction}
  def move({:south, amount}, {a, b, direction}), do: {a - amount, b, direction}
  def move({:east, amount}, {a, b, direction}), do: {a, b + amount, direction}
  def move({:west, amount}, {a, b, direction}), do: {a, b - amount, direction}

  defp rotate(amount, a, b, direction) do
    new_index = Enum.find_index(@directions, &(&1 == direction)) + round(amount / 90)
    {a, b, Enum.at(@directions, rem(new_index, 4))}
  end
end
