defmodule Point do
  defstruct x: 0, y: 0
end

defmodule Intersection do
  defstruct point: %Point{}, steps: 0
end

defmodule Segment do
  defstruct start: %Point{}, end: %Point{}, steps: 0

  def get_intersection(%Segment{} = horizontal, %Segment{} = vertical) do
    if intersects(horizontal, vertical) do
      [
        %Intersection{
          point: get_intersection_point(horizontal, vertical),
          steps: get_intersection_steps(horizontal, vertical)
        }
      ]
    else
      []
    end
  end

  def intersects(%Segment{} = horizontal, %Segment{} = vertical) do
    y = horizontal.start.y
    x = vertical.start.x
    x_upper = max(horizontal.start.x, horizontal.end.x)
    x_lower = min(horizontal.start.x, horizontal.end.x)
    y_upper = max(horizontal.start.y, horizontal.end.y)
    y_lower = min(horizontal.start.y, horizontal.end.y)

    x >= x_lower and x <= x_upper and y >= y_lower && y <= y_upper
  end

  def get_intersection_point(%Segment{} = horizontal, %Segment{} = vertical) do
    %Point{x: vertical.start.x, y: horizontal.start.y}
  end

  def get_intersection_steps(%Segment{} = horizontal, %Segment{} = vertical) do
    intersection = get_intersection_point(horizontal, vertical)

    horizontal.steps - abs(horizontal.end.x - intersection.x) +
      vertical.steps - abs(vertical.end.y - intersection.y)
  end
end

defmodule Command do
  defstruct direction: :up, amount: 0

  def new(command) do
    {dir, amt} = String.split_at(command, 1)
    amt = String.to_integer(amt)

    case String.upcase(dir) do
      "U" -> %Command{direction: :up, amount: amt}
      "D" -> %Command{direction: :down, amount: amt}
      "L" -> %Command{direction: :left, amount: amt}
      "R" -> %Command{direction: :right, amount: amt}
    end
  end

  def move(%Command{} = self, pos) do
    case self.direction do
      :up -> %Point{x: pos.x, y: pos.y + self.amount}
      :down -> %Point{x: pos.x, y: pos.y - self.amount}
      :left -> %Point{x: pos.x - self.amount, y: pos.y}
      :right -> %Point{x: pos.x + self.amount, y: pos.y}
    end
  end
end

defmodule Day3 do
  def parse(file) do
    File.stream!(file)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn wire -> String.split(wire, ",", trim: true) end)
  end

  def get_wire_segments(wire) do
    segments =
      wire
      |> Stream.map(&Command.new/1)
      |> Enum.reduce(%{point: %Point{}, steps: 0, horiz: [], vert: []}, fn command, accum ->
        segment = %Segment{
          start: accum.point,
          end: Command.move(command, accum.point),
          steps: accum.steps + command.amount
        }

        case command.direction do
          x when x == :up or x == :down ->
            %{
              point: segment.end,
              steps: segment.steps,
              horiz: accum.horiz,
              vert: [segment | accum.vert]
            }

          x when x == :left or x == :right ->
            %{
              point: segment.end,
              steps: segment.steps,
              horiz: [segment | accum.horiz],
              vert: accum.vert
            }
        end
      end)

    {Enum.reverse(segments.horiz), Enum.reverse(segments.vert)}
  end

  def get_intersections(horizontal, vertical) do
    vertical
    |> Enum.flat_map(fn vert ->
      lower = min(vert.start.y, vert.end.y)
      upper = max(vert.start.y, vert.end.y)

      horizontal
      |> Enum.filter(fn seg -> seg.end.y >= lower and seg.end.y <= upper end)
      |> Enum.flat_map(fn horiz -> Segment.get_intersection(horiz, vert) end)
    end)
  end

  def manhatten_distance(point) do
    abs(point.x) + abs(point.y)
  end

  def part_one(wires) do
    [{horiz1, vert1}, {horiz2, vert2}] = wires |> Enum.map(&get_wire_segments/1)

    (get_intersections(horiz2, vert1) ++ get_intersections(horiz1, vert2))
    |> Stream.filter(fn intersection ->
      not (intersection.point.x == 0 and intersection.point.y == 0)
    end)
    |> Stream.map(fn intersection -> intersection.point end)
    |> Enum.map(&manhatten_distance/1)
    |> Enum.min()
  end

  def part_two(wires) do
    [{horiz1, vert1}, {horiz2, vert2}] = wires |> Enum.map(&get_wire_segments/1)

    # (get_intersections(horiz2, vert1) ++ get_intersections(horiz1, vert2))
    # |> inspect()
    # |> IO.puts()

    (get_intersections(horiz2, vert1) ++ get_intersections(horiz1, vert2))
    |> Stream.filter(fn intersection ->
      not (intersection.point.x == 0 and intersection.point.y == 0)
    end)
    |> Enum.map(fn intersection -> intersection.steps end)
    |> Enum.min()
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

Day3.run()
