defmodule Aoc2020.Day08 do
  def part1(input) do
    input |> Enum.map(&parse/1) |> run_program(0, 0, []) |> elem(1)
  end

  def part2(input) do
    instructions = input |> Enum.map(&parse/1)

    0..(length(instructions) - 1)
    |> Enum.map(&update_instruction(&1, instructions))
    |> Enum.map(&run_program(&1, 0, 0, []))
    |> Enum.filter(fn
      {:end, _} -> true
      _ -> false
    end)
    |> Enum.at(0)
    |> elem(1)
  end

  defp parse(line) do
    [op, count] = String.split(line, " ")
    {op, String.to_integer(count)}
  end

  defp update_instruction(0, [{"nop", v} | rest]), do: [{"jmp", v} | rest]
  defp update_instruction(0, [{"jmp", v} | rest]), do: [{"nop", v} | rest]
  defp update_instruction(0, [{i, v} | rest]), do: [{i, v} | rest]
  defp update_instruction(loc, [head | rest]), do: [head | update_instruction(loc - 1, rest)]

  defp run_program(instructions, loc, acc, visited) do
    instruction = Enum.at(instructions, loc)

    if is_nil(instruction) do
      {:end, acc}
    else
      [new_loc, new_acc] = run_instruction(instruction, loc, acc)

      if Enum.member?(visited, new_loc) do
        {:loop, new_acc}
      else
        run_program(instructions, new_loc, new_acc, [new_loc | visited])
      end
    end
  end

  defp run_instruction({"nop", _}, loc, acc), do: [loc + 1, acc]
  defp run_instruction({"acc", v}, loc, acc), do: [loc + 1, acc + v]
  defp run_instruction({"jmp", v}, loc, acc), do: [loc + v, acc]
end
