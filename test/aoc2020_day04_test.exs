defmodule Aoc2020Day04Test do
  use ExUnit.Case, async: true
  alias Aoc2020.Day04

  @full_data File.read!("inputs/day04.txt")
             |> String.trim()
             |> String.split("\n\n")

  @example_data File.read!("inputs/day04_example.txt")
                |> String.trim()
                |> String.split("\n\n")

  @valid_data File.read!("inputs/day04_valid.txt")
              |> String.trim()
              |> String.split("\n\n")

  @invalid_data File.read!("inputs/day04_invalid.txt")
                |> String.trim()
                |> String.split("\n\n")

  test "p1: default example" do
    assert Day04.part1(@example_data) == 2
  end

  test "p1: full" do
    assert Day04.part1(@full_data) == 247
  end

  test "p2: default examples" do
    assert Day04.part2(@valid_data) == 4
    assert Day04.part2(@invalid_data) == 0
  end

  test "byr_valid" do
    refute Day04.byr_valid(%{"byr" => "1234"})
    assert Day04.byr_valid(%{"byr" => "1920"})
    assert Day04.byr_valid(%{"byr" => "2002"})
    refute Day04.byr_valid(%{"byr" => "2003"})
    refute Day04.byr_valid(%{"byr" => "2021"})
  end

  test "iyr_valid" do
    refute Day04.iyr_valid(%{"iyr" => "1234"})
    assert Day04.iyr_valid(%{"iyr" => "2010"})
    assert Day04.iyr_valid(%{"iyr" => "2020"})
  end

  test "eyr_valid" do
    refute Day04.eyr_valid(%{"eyr" => "2019"})
    assert Day04.eyr_valid(%{"eyr" => "2030"})
    assert Day04.eyr_valid(%{"eyr" => "2020"})
  end

  test "hgt_valid" do
    assert Day04.hgt_valid(%{"hgt" => "60in"})
    assert Day04.hgt_valid(%{"hgt" => "190cm"})
    refute Day04.hgt_valid(%{"hgt" => "190in"})
    refute Day04.hgt_valid(%{"hgt" => "60cm"})
    refute Day04.hgt_valid(%{"hgt" => "60"})
  end

  test "hcl_valid" do
    assert Day04.hcl_valid(%{"hcl" => "#123123"})
    assert Day04.hcl_valid(%{"hcl" => "#ffffff"})
    refute Day04.hcl_valid(%{"hcl" => "#fffff"})
    refute Day04.hcl_valid(%{"hcl" => "#fffffff"})
    refute Day04.hcl_valid(%{"hcl" => "fff"})
  end

  test "ecl_valid" do
    assert Day04.ecl_valid(%{"ecl" => "amb"})
    assert Day04.ecl_valid(%{"ecl" => "blu"})
    assert Day04.ecl_valid(%{"ecl" => "gry"})
    refute Day04.ecl_valid(%{"ecl" => "xyz"})
  end

  test "pid_valid" do
    assert Day04.pid_valid(%{"pid" => "111111111"})
    refute Day04.pid_valid(%{"pid" => "11111f111"})
    refute Day04.pid_valid(%{"pid" => "11111111111"})
    refute Day04.pid_valid(%{"pid" => "1111111"})
  end

  test "p2: full" do
    assert Day04.part2(@full_data) == 145
  end
end
