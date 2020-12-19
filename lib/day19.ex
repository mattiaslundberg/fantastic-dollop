defmodule Aoc2020.Day19 do
  def part1([rule_input, messages_input]) do
    rules = parse_rules(rule_input)

    messages_input
    |> String.split("\n")
    |> Enum.map(fn m ->
      matches_rule(rules, m |> String.codepoints(), 0)
    end)
    |> Enum.reduce(0, fn
      {true, []}, r -> r + 1
      _, r -> r
    end)
  end

  def part2([rule_input, messages_input]) do
    rules =
      rule_input
      |> parse_rules()
      |> Map.put(8, [[42], [42, 8]])
      |> Map.put(11, [[42, 31], [42, 11, 31]])

    messages_input
    |> String.split("\n")
    |> Enum.map(fn m ->
      matches_rule(rules, String.codepoints(m), 0)
    end)
    |> Enum.reduce(0, fn
      {true, []}, r -> r + 1
      _, r -> r
    end)
  end

  def matches_rule(_, [], _), do: {false, []}

  def matches_rule(rules, {message1, message2}, rule_id) do
    normalize(
      matches_rule(rules, message2, rule_id),
      matches_rule(rules, message1, rule_id)
    )
  end

  def matches_rule(rules, message, rule_id) do
    rule = Map.get(rules, rule_id)

    case rule do
      r when is_binary(r) ->
        {r == hd(message), tl(message)}

      [l1, l2] when is_list(l1) and is_list(l2) ->
        check_branch(rules, message, l1, l2)

      l when is_list(l) ->
        check_list(rules, message, l)
    end
  end

  defp check_branch(rules, message, l1, l2) do
    {check_list(rules, message, l1), check_list(rules, message, l2)}
  end

  defp check_list(_, message, []), do: {true, message}

  defp check_list(rules, message, [r | rr]) do
    case matches_rule(rules, message, r) do
      {{true, rem1}, {true, rem2}} ->
        a = check_list(rules, rem1, rr)
        b = check_list(rules, rem2, rr)
        normalize(a, b)

      {{true, rem}, _} when is_list(rem) ->
        check_list(rules, rem, rr)

      {_, {true, rem}} when is_list(rem) ->
        check_list(rules, rem, rr)

      {true, rem} when is_list(rem) ->
        check_list(rules, rem, rr)

      {{false, _}, {false, _}} ->
        {false, []}

      {false, rem} when is_list(rem) ->
        {false, []}
    end
  end

  def normalize({true, []}, _), do: {true, []}
  def normalize(_, {true, []}), do: {true, []}
  def normalize({true, rem}, {false, _}), do: {true, rem}
  def normalize({false, _}, {true, rem}), do: {true, rem}
  def normalize({true, rem}, {true, rem1}), do: {true, {rem, rem1}}
  def normalize(_, _), do: {false, []}

  def parse_rules(rule_input) do
    rule_input |> String.split("\n") |> Enum.reduce(Map.new(), &parse_rule_line/2)
  end

  def parse_rule_line(rule_line, rules) do
    [index, rule] = rule_line |> String.split(": ")

    Map.put(rules, String.to_integer(index), parse_rule(rule))
  end

  def parse_rule(rule) do
    cond do
      String.starts_with?(rule, "\"") ->
        String.split(rule, "\"") |> Enum.at(1)

      String.contains?(rule, "|") ->
        rule
        |> String.split("|")
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> Enum.map(fn l -> Enum.map(l, &String.to_integer/1) end)

      true ->
        rule
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
    end
  end
end
