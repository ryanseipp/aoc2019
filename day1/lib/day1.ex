defmodule Day1 do
  def calc_fuel(weight) do
    Integer.floor_div(weight, 3) - 2
  end

  def account_for_fuel(fuel) when fuel > 0 do
    fuel + account_for_fuel(calc_fuel(fuel))
  end

  def account_for_fuel(fuel) when fuel <= 0 do
    0
  end

  def parse(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn x -> x != "" end)
    |> Stream.map(&String.to_integer/1)
  end

  def part_one(weights) do
    weights
    |> Stream.map(&calc_fuel/1)
    |> Enum.sum()
  end

  def part_two(weights) do
    weights
    |> Stream.map(&calc_fuel/1)
    |> Stream.map(&account_for_fuel/1)
    |> Enum.sum()
  end

  def run() do
    IO.puts("Part 1: ")

    parse("lib/input.txt")
    |> part_one()
    |> IO.puts()

    IO.puts("\nPart 2: ")

    parse("lib/input.txt")
    |> part_two()
    |> IO.puts()
  end
end

Day1.run()
