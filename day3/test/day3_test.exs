defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "command_new" do
    input = ["R83", "U42", "L75", "D30"]

    expected = [
      %Command{direction: :right, amount: 83},
      %Command{direction: :up, amount: 42},
      %Command{direction: :left, amount: 75},
      %Command{direction: :down, amount: 30}
    ]

    sut = input |> Enum.map(&Command.new/1)
    assert sut == expected
  end

  test "command_move_right" do
    cmd = %Command{direction: :right, amount: 83}
    pos = %Point{x: 0, y: 0}
    expected = %Point{x: 83, y: 0}

    sut = Command.move(cmd, pos)
    assert sut == expected
  end

  test "command_move_left" do
    cmd = %Command{direction: :left, amount: 83}
    pos = %Point{x: 0, y: 0}
    expected = %Point{x: -83, y: 0}

    sut = Command.move(cmd, pos)
    assert sut == expected
  end

  test "command_move_up" do
    cmd = %Command{direction: :up, amount: 83}
    pos = %Point{x: 0, y: 0}
    expected = %Point{x: 0, y: 83}

    sut = Command.move(cmd, pos)
    assert sut == expected
  end

  test "command_move_down" do
    cmd = %Command{direction: :down, amount: 83}
    pos = %Point{x: 0, y: 0}
    expected = %Point{x: 0, y: -83}

    sut = Command.move(cmd, pos)
    assert sut == expected
  end

  test "segment_intersects" do
    seg1 = %Segment{start: %Point{x: 0, y: 0}, end: %Point{x: 3, y: 0}}
    seg2 = %Segment{start: %Point{x: 1, y: 1}, end: %Point{x: 1, y: -1}}
    expected = true

    assert Segment.intersects(seg1, seg2) == expected
  end

  test "segment_does_not_intersect" do
    seg1 = %Segment{start: %Point{x: 0, y: 0}, end: %Point{x: 3, y: 0}}
    seg2 = %Segment{start: %Point{x: 4, y: 1}, end: %Point{x: 4, y: -1}}
    expected = false

    assert Segment.intersects(seg1, seg2) == expected
  end

  test "get_wire_segments" do
    input = ["R83", "U42", "L75", "D30"]

    expected = {
      [
        %Segment{start: %Point{x: 0, y: 0}, end: %Point{x: 83, y: 0}, steps: 83},
        %Segment{start: %Point{x: 83, y: 42}, end: %Point{x: 8, y: 42}, steps: 200}
      ],
      [
        %Segment{start: %Point{x: 83, y: 0}, end: %Point{x: 83, y: 42}, steps: 125},
        %Segment{start: %Point{x: 8, y: 42}, end: %Point{x: 8, y: 12}, steps: 230}
      ]
    }

    sut = input |> Day3.get_wire_segments()
    assert sut == expected
  end

  test "part 2 example 1" do
    input = [
      ["R8", "U5", "L5", "D3"],
      ["U7", "R6", "D4", "L4"]
    ]

    expected = 30

    sut = input |> Day3.part_two()
    assert sut == expected
  end

  test "part 2 example 2" do
    input = [
      ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
      ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
    ]

    expected = 610

    sut = input |> Day3.part_two()
    assert sut == expected
  end

  test "part 2 example 3" do
    input = [
      ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
      ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
    ]

    expected = 410

    sut = input |> Day3.part_two()
    assert sut == expected
  end
end
