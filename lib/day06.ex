defmodule Day06 do
  def part1(input) do
    [times, distance] = String.split(input, "\n")
    races = Enum.zip(parse_num_list(times), parse_num_list(distance))

    Enum.map(races, fn {total_time, max_distance} -> count_win_variants(total_time, max_distance) end)
    |> Enum.product()
  end

  def part2(input) do
    [times, distance] = String.split(input, "\n")
    total_time = parse_big_num(times)
    max_distance = parse_big_num(distance)

    count_win_variants(total_time, max_distance)
  end

  # calculation via quadratic equation
  defp count_win_variants(total_time, max_distance) do
    min = Float.ceil((total_time - :math.sqrt(total_time * total_time - 4 * max_distance)) / 2 + 0.00001)
    max = Float.floor((total_time + :math.sqrt(total_time * total_time - 4 * max_distance)) / 2 - 0.00001)
    round(max - min + 1)
  end

  defp parse_num_list(line) do
    [_, nums] = String.split(line, ":")
    String.split(nums, " ") |> Enum.filter(&(&1 != "")) |> Enum.map(&String.trim/1) |> Enum.map(&String.to_integer/1)
  end

  defp parse_big_num(line) do
    [_, num] = String.split(line, ":")
    String.split(num, " ") |> Enum.filter(&(&1 != "")) |> Enum.map(&String.trim/1) |> Enum.join() |> String.to_integer()
  end
end
