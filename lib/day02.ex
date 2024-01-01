defmodule Day02 do
  def sum_possible_games(input) do
    possible_sets = %{"red" => 12, "green" => 13, "blue" => 14}

    parse_input(input)
    |> Enum.map(fn {game_id, draws} ->
      result = Enum.all?(draws, fn draw ->
        Enum.all?(draw, fn {colour, num} ->
          num <= Map.get(possible_sets, colour)
        end)
      end)

      {game_id, result}
    end)
    |> Enum.filter(fn {_, result} -> result end)
    |> Enum.map(fn {game_num, _} -> game_num end)
    |> Enum.sum()
  end

  def multiply_min_sets(input) do
    parse_input(input)
    |> Enum.map(fn {_, draws} ->
      Enum.reduce(draws, %{"red" => -1, "green" => -1, "blue" => -1}, fn draw, result_map ->
        Enum.reduce(draw, result_map, fn {color, num}, result_map ->
          if num > Map.get(result_map, color) do
            Map.put(result_map, color, num)
          else
            result_map
          end
        end)
      end)
      |> Map.values()
      |> Enum.product()
    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(&parse_game/1)
  end

  defp parse_game(line) do
    [_, game_num_str, sets_str] = Regex.run(~r/Game (\d+): (.+)/, line)
    sets_str = String.split(sets_str, ";")
    |> Enum.map(&String.trim/1)

    result = Enum.map(sets_str, fn set ->
      colour_draws = String.split(set, ",") |> Enum.map(&String.trim/1)
      parse_color_draw(colour_draws)
    end)

    {String.to_integer(game_num_str), result}
  end

  defp parse_color_draw(draw_str) do
    Enum.map(draw_str, fn color_draw_str ->
      [num_str, color] = String.split(color_draw_str, " ")
      {color, String.to_integer(num_str)}
    end)
    |> Map.new()
  end
end
