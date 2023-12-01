defmodule Day01 do

  def sum_calibration_num(input) do
   sum_calibration(String.split(input, "\n"))
  end

  def sum_calibration_num_text(input) do
    replace_map = %{
      "one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9
    }

    sum_calibration(String.split(input, "\n"), replace_map)
  end

  defp sum_calibration(input, replace_map \\ %{}) do
    replace_nums = Enum.concat(Map.keys(replace_map), Enum.map(1..9, &Integer.to_string/1))

    Enum.map(input, fn line ->

      for index <- (0..(String.length(line)-1)),
          num <- replace_nums,
          {_, rest} = String.split_at(line, index),
          String.starts_with?(rest, num),
        do: {num, index}

    end)
    |> Enum.map(fn captures ->
      {{digit1, _}, {digit2, _}} = Enum.min_max_by(captures, fn {_, pos} -> pos end)
      10 * get_or_parse(replace_map, digit1) + get_or_parse(replace_map, digit2)
    end)
    |> Enum.sum()
  end

  defp get_or_parse(replace_map, num) do
    Map.get_lazy(replace_map, num, fn -> String.to_integer(num) end)
  end
end
