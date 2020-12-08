defmodule Aoc2020.Day08 do
  def part1(input) do
    input |> Enum.map(&parse/1) |> run_until_loop(0, 0, [])
  end

  def part2(input) do
    instructions = input |> Enum.map(&parse/1)

    0..(length(instructions) - 1)
    |> Enum.map(&check_terminates(&1, instructions))
    |> Enum.filter(&Function.identity/1)
    |> Enum.at(0)
  end

  defp parse(line) do
    [op, count] = String.split(line, " ")
    {op, String.to_integer(count)}
  end

  defp check_terminates(loc_to_change, instructions) do
    update_instruction(loc_to_change, instructions) |> run_until_terminate(0, 0, [])
  end

  defp update_instruction(0, [{"nop", v} | rest]), do: [{"jmp", v} | rest]
  defp update_instruction(0, [{"jmp", v} | rest]), do: [{"nop", v} | rest]
  defp update_instruction(0, [{i, v} | rest]), do: [{i, v} | rest]
  defp update_instruction(loc, [head | rest]), do: [head | update_instruction(loc - 1, rest)]

  defp run_until_terminate(instructions, loc, acc, visited) do
    instruction = Enum.at(instructions, loc)

    if is_nil(instruction) do
      acc
    else
      [loc, acc] = run_instruction(instruction, loc, acc)

      if Enum.member?(visited, loc) do
        false
      else
        run_until_terminate(instructions, loc, acc, [loc | visited])
      end
    end
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
