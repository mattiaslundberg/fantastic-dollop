defmodule Aoc2020.Day20 do
  def part1(tiles_data) do
    tiles =
      for tile <- tiles_data, into: Map.new() do
        tile |> String.split("\n") |> parse_tile()
      end

    place_tiles(tiles, nil)
  end

  def part2(_input) do
    :ok
  end

  def place_tiles([], main), do: main

  def place_tiles([take | rest], main) when is_nil(main) do
    place_tiles(rest, take)
  end

  def place_tiles(unused_tiles, main) do
    # Try as is
    # Try rotated (3 times)
    # Try flipped (2)
    # Try flipped and rotated (2 * 3)
    # move last in unused if no match
  end

  def place_tile(new = {_new_id, new_pixels, _}, main = {id, pixels, [r, d, l, u]}) do
    placed_here =
      cond do
        is_nil(r) and rightmost(pixels) == leftmost(new_pixels) ->
          {true, {id, pixels, [new, d, l, u]}}

        is_nil(d) and bottom(pixels) == top(new_pixels) ->
          {true, {id, pixels, [r, new, l, u]}}

        is_nil(l) and leftmost(pixels) == rightmost(new_pixels) ->
          {true, {id, pixels, [r, d, new, u]}}

        is_nil(u) and top(pixels) == bottom(new_pixels) ->
          {true, {id, pixels, [r, d, l, new]}}

        true ->
          {false, main}
      end
  end

  def top(pixels), do: Enum.at(pixels, 0)
  def bottom(pixels), do: Enum.at(pixels, -1)
  def rightmost(pixels), do: Enum.map(pixels, &Enum.at(&1, -1))
  def leftmost(pixels), do: Enum.map(pixels, &Enum.at(&1, 0))

  def parse_tile(["Tile " <> id_data | pixel_data]) do
    {id, _} = Integer.parse(id_data)

    pixels = for line <- pixel_data, do: String.split(line, "", trim: true)

    {id, pixels, [nil, nil, nil, nil]}
  end
end
