defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "part 1 example 1" do
    assert [1, 0, 0, 0, 99] |> Day2.part_one(0) == 2
  end

  test "part 1 example 2" do
    assert [2, 3, 0, 3, 99] |> Day2.part_one(0) == 2
  end

  test "part 1 example 3" do
    assert [2, 4, 4, 5, 99, 0] |> Day2.part_one(0) == 2
  end

  test "part 1 example 4" do
    assert [1, 1, 1, 4, 99, 5, 6, 0, 99] |> Day2.part_one(0) == 30
  end
end
