defmodule Aoc2020.Day04 do
  @required_keys [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
  ]

  def part1(input) do
    input
    |> Enum.map(&parse_passport_string/1)
    |> Enum.map(&has_fields?/1)
    |> Enum.filter(&Function.identity/1)
    |> length()
  end

  def part2(input) do
    input
    |> Enum.map(&parse_passport_string/1)
    |> Enum.map(&validate_passport/1)
    |> Enum.filter(&Function.identity/1)
    |> length()
  end

  def validate_passport(p) do
    has_fields?(p) and byr_valid(p) and iyr_valid(p) and eyr_valid(p) and
      hgt_valid(p) and hcl_valid(p) and ecl_valid(p) and pid_valid(p)
  end

  def byr_valid(%{"byr" => byr}) do
    value = String.to_integer(byr)
    value >= 1920 and value <= 2002
  end

  def iyr_valid(%{"iyr" => iyr}) do
    value = String.to_integer(iyr)
    value >= 2010 and value <= 2020
  end

  def eyr_valid(%{"eyr" => eyr}) do
    value = String.to_integer(eyr)
    value >= 2020 and value <= 2030
  end

  def hgt_valid(%{"hgt" => hgt}) do
    case Integer.parse(hgt) do
      {v, "cm"} ->
        v >= 150 and v <= 193

      {v, "in"} ->
        v >= 59 and v <= 76

      _ ->
        false
    end
  end

  def hcl_valid(%{"hcl" => "#" <> col}) do
    Regex.match?(~r/^[0-9a-f]{6}$/, col)
  end

  def hcl_valid(_), do: false

  def ecl_valid(%{"ecl" => ecl}) do
    valid = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    ecl in valid
  end

  def pid_valid(%{"pid" => pid}) do
    Regex.match?(~r/^[0-9]{9}$/, pid)
  end

  def has_fields?(p) do
    required = MapSet.new(@required_keys)

    p
    |> Map.keys()
    |> MapSet.new()
    |> (&MapSet.subset?(required, &1)).()
  end

  def parse_passport_string(str) do
    str
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.map(&String.split(&1, ":"))
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
