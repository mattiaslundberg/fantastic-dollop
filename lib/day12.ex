defmodule Aoc2020.Day12 do
  @directions [:east, :south, :west, :north]
  def part1(input) do
    {a, b, _} = input |> Enum.map(&transform/1) |> Enum.reduce({0, 0, :east}, &move/2)
    abs(a) + abs(b)
  end

  def part2(_input) do
    :ok
  end

  def transform("F" <> num), do: {:forward, String.to_integer(num)}
  def transform("R" <> num), do: {:right, String.to_integer(num)}
  def transform("L" <> num), do: {:left, String.to_integer(num)}
  def transform("N" <> num), do: {:north, String.to_integer(num)}
  def transform("E" <> num), do: {:east, String.to_integer(num)}
  def transform("S" <> num), do: {:south, String.to_integer(num)}
  def transform("W" <> num), do: {:west, String.to_integer(num)}

  def move({:forward, amount}, {a, b, :east}), do: {a, b + amount, :east}
  def move({:forward, amount}, {a, b, :north}), do: {a + amount, b, :north}
  def move({:forward, amount}, {a, b, :south}), do: {a - amount, b, :south}
  def move({:forward, amount}, {a, b, :west}), do: {a, b - amount, :west}
  def move({:right, amount}, {a, b, direction}), do: rotate(&Kernel.+/2, amount, a, b, direction)
  def move({:left, amount}, {a, b, direction}), do: rotate(&Kernel.-/2, amount, a, b, direction)
  def move({:north, amount}, {a, b, current_direction}), do: {a + amount, b, current_direction}
  def move({:south, amount}, {a, b, current_direction}), do: {a - amount, b, current_direction}
  def move({:east, amount}, {a, b, current_direction}), do: {a, b + amount, current_direction}
  def move({:west, amount}, {a, b, current_direction}), do: {a, b - amount, current_direction}

  defp rotate(move_fn, amount, a, b, direction) do
    current_index = Enum.find_index(@directions, fn v -> v == direction end)
    new_direction = Enum.at(@directions, rem(move_fn.(current_index, round(amount / 90)), 4))
    {a, b, new_direction}
  end
end
