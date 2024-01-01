alias Grid
alias Grid.Element

defmodule Day03 do
  def part1(input) do
    {part_nums, _} = collect_part_nums_gears(input)
    Enum.sum(part_nums)
  end

  def part2(input) do
    {_, gears} = collect_part_nums_gears(input)
    Map.filter(gears, fn {_, v} -> length(v) == 2 end)
    |> Map.values() |> Enum.map(fn [a, b] -> a * b end) |> Enum.sum()
  end

  defp collect_part_nums_gears(input) do
    grid = parse_input(input)

    {part_nums, gears, _} = Enum.reduce(grid, {[], %{}, ""}, fn elem, {part_nums, gears, current_num_str} ->
      case Integer.parse(elem.val) do
        {_val, ""} ->
          {part_nums, gears, current_num_str <> elem.val}

        :error when current_num_str != "" ->
          new_part_nums = adjust_part_nums(grid, current_num_str, elem, part_nums)
          new_gears = adjust_gears(grid, current_num_str, elem, gears)
          {new_part_nums, new_gears, ""}

        :error ->
          {part_nums, gears, current_num_str}
      end
    end)

    {part_nums, gears}
  end

  defp adjust_part_nums(grid, str, elem, part_nums) do
    valid_part_num? = list_adjacent_positions(grid, str, elem)
    |> Enum.any?(fn %Element{val: x} ->
      x != "." and Integer.parse(x) == :error
    end)

    if valid_part_num? do
      {num, _} = Integer.parse(str)
      [num | part_nums]
    else
      part_nums
    end
  end

  def adjust_gears(grid, str, current_position, gears) do
    gear_position = list_adjacent_positions(grid, str, current_position)
    |> Enum.find(fn elem ->
      elem.val == "*"
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

  defp list_adjacent_positions(grid, str, elem) do
    {row, last_col} = if elem.col == 0 do
      {elem.row - 1, grid.width - 1}
    else
      {elem.row, elem.col - 1}
    end

    first_col = last_col - String.length(str) + 1

    Enum.flat_map(first_col..last_col, fn col ->
      Grid.adjacent(grid, row, col, :diagonal)
    end)
  end

  defp parse_input(input), do: Grid.parse(input)
end
