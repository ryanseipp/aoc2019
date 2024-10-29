defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "day 1 example 1" do
    assert Day1.part_one([12]) == 2
  end

  test "day 1 example 2" do
    assert Day1.part_one([14]) == 2
  end

  test "day 1 example 3" do
    assert Day1.part_one([1969]) == 654
  end

  test "day 1 example 4" do
    assert Day1.part_one([100_756]) == 33583
  end

  test "day 2 example 1" do
    assert Day1.part_two([14]) == 2
  end

  test "day 2 example 2" do
    assert Day1.part_two([1969]) == 966
  end

  test "day 2 example 3" do
    assert Day1.part_two([100_756]) == 50346
  end
end
