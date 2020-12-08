defmodule Aoc2020.Day08 do
  def part1(input) do
    input |> Enum.map(&parse/1) |> run_until_loop(0, 0, [])
  end

  def part2(_input) do
    :ok
  end

  defp parse(line) do
    [op, count] = String.split(line, " ")
    {op, String.to_integer(count)}
  end

  defp run_until_loop(instructions, loc, acc, visited) do
    [loc, acc] =
      instructions
      |> Enum.at(loc)
      |> run_instruction(loc, acc)

    if Enum.member?(visited, loc) do
      acc
    else
      run_until_loop(instructions, loc, acc, [loc | visited])
    end
  end

  defp run_instruction({"nop", _}, loc, acc), do: [loc + 1, acc]
  defp run_instruction({"acc", v}, loc, acc), do: [loc + 1, acc + v]
  defp run_instruction({"jmp", v}, loc, acc), do: [loc + v, acc]
end
