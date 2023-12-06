defmodule Day06 do
  def part1(input) do
    [times, distance] = String.split(input, "\n")
    races = Enum.zip(parse_num_list(times), parse_num_list(distance))

    Enum.map(races, fn {total_time, max_distance} ->
      count_win_variants(total_time, max_distance)
    end)
    |> Enum.reduce(1, &(&1 * &2))
  end

  def part2(input) do
    [times, distance] = String.split(input, "\n")
    total_time = parse_big_num(times)
    max_distance = parse_big_num(distance)

    count_win_variants(total_time, max_distance)
  end

  defp count_win_variants(total_time, max_distance) do
    Enum.filter(0..total_time, fn time_charging ->
      time_driving = total_time - time_charging
      distance_driven = time_driving * time_charging
      distance_driven > max_distance
    end)
    |> Enum.count()
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
