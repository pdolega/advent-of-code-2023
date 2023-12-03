alias Adventurous.Point
alias Adventurous.Point.Point2D

defmodule Day03 do
  def sum_part_numbers(input) do
    {part_nums, _} = collect_part_nums_gears(input)

    Enum.sum(part_nums)
  end

  def sum_gear_ratios(input) do
    {_, gears} = collect_part_nums_gears(input)

    Map.filter(gears, fn {_, v} -> length(v) == 2 end)
    |> Map.values()
    |> Enum.reduce(0, fn [a, b], sum -> sum + a * b end)
  end

  defp collect_part_nums_gears(input) do
    {grid, width, height} = parse_input(input)

    points = for x <- 0..(height-1), y <- 0..width do
      %Point2D{x: x, y: y}
    end

    {part_nums, gears, _} = Enum.reduce(points, {[], %{}, ""}, fn point, {part_nums, gears, current_num_str} ->
      x = Map.get(grid, point, ".")

      case Integer.parse(x) do
        {_num, _} ->
          {part_nums, gears, current_num_str <> x}

        :error when current_num_str != "" ->
          new_part_nums = adjust_part_nums(current_num_str, point, grid, part_nums)
          new_gears = adjust_gears(current_num_str, point, grid, gears)
          {new_part_nums, new_gears, ""}

        :error ->
          {part_nums, gears, current_num_str}
      end
    end)

    {part_nums, gears}
  end

  defp adjust_part_nums(str, current_position, grid, part_nums) do
    valid_part_num? = list_adjacent_positions(str, current_position)
    |> Enum.any?(fn point ->
      x = Map.get(grid, point, ".")
      x != "." and Integer.parse(x) == :error
    end)

    if valid_part_num? do
      {num, _} = Integer.parse(str)
      [num | part_nums]
    else
      part_nums
    end
  end

  def adjust_gears(str, current_position, grid, gears) do
    gear_position = list_adjacent_positions(str, current_position)
    |> Enum.find(fn point ->
      Map.get(grid, point, ".") == "*"
    end)

    case gear_position do
      nil ->
        gears

      gear_position ->
        {num, _} = Integer.parse(str)
        parts = Map.get(gears, gear_position, [])
        Map.put(gears, gear_position, [num | parts])
    end
  end

  defp list_adjacent_positions(str, current_position) do
    last_y = current_position.y - 1
    first_y = current_position.y - String.length(str)

    Enum.flat_map(first_y..last_y, fn y ->
      Point.adjacent(%Point2D{x: current_position.x, y: y}, :diagonal)
    end)
  end

  defp parse_input(input) do
    lines = String.split(input, "\n")

    map = Enum.with_index(lines)
    |> Enum.flat_map(fn {line, row_idx} ->
      String.graphemes(line)
      |> Enum.with_index
      |> Enum.map(fn {letter, idx} ->
        { %Point2D{x: row_idx, y: idx}, letter }
      end)
    end)
    |> Map.new

    width = String.length(hd(lines))
    height = Enum.count(lines)

    {map, width, height}
  end
end
