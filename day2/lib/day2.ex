defmodule Day2 do
  def parse(file) do
    File.read!(file)
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def replace_at(list, idx, value) do
    list
    |> Enum.with_index()
    |> Enum.map(fn
      {_, ^idx} -> value
      {value, _} -> value
    end)
  end

  def part_one(intcode, pos) do
    case Enum.slice(intcode, pos..-1//1) do
      [1, x, y, z | _] ->
        part_one(
          replace_at(intcode, z, Enum.at(intcode, x) + Enum.at(intcode, y)),
          pos + 4
        )

      [2, x, y, z | _] ->
        part_one(
          replace_at(intcode, z, Enum.at(intcode, x) * Enum.at(intcode, y)),
          pos + 4
        )

      [99 | _] ->
        List.first(intcode)
    end
  end

  def try_all_verbs(intcode, noun, max) do
    [head, _, _ | tail] = intcode

    0..max
    |> Enum.find(fn verb ->
      part_one([head, noun, verb | tail], 0) == 19_690_720
    end)
  end

  def part_two(intcode) do
    max = length(intcode) - 1

    0..max
    |> Enum.find_value(fn noun ->
      case try_all_verbs(intcode, noun, max) do
        nil -> false
        verb -> 100 * noun + verb
      end
    end)
  end

  def run() do
    IO.puts("Part 1: ")

    parse("lib/input.txt")
    |> part_one(0)
    |> IO.puts()

    IO.puts("\nPart 2: ")

    parse("lib/input.txt")
    |> part_two()
    |> IO.puts()
  end
end

Day2.run()
