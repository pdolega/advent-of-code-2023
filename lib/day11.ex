alias Adventurous.Point.Point2D

defmodule Day11 do
  def part1(input) do
    calculate_distances(input, 2)
  end

  def part2(input, expansion_factor) do
    calculate_distances(input, expansion_factor)
  end

  defp calculate_distances(input, expansion_factor) do
    galaxy_map = parse_input(input)
    {void_rows, void_cols} = find_void(galaxy_map)
    galaxy_pairs = pair_galaxies(galaxy_map)

    Enum.map(galaxy_pairs, fn {galaxy1, galaxy2} ->
      crossed_empty_rows = count_void(void_rows, galaxy1.x, galaxy2.x)
      crossed_empty_cols = count_void(void_cols, galaxy1.y, galaxy2.y)
      crossed_void = (crossed_empty_rows + crossed_empty_cols) * (expansion_factor-1)
      abs(galaxy1.x - galaxy2.x) + abs(galaxy1.y - galaxy2.y) + crossed_void
    end)
    |> Enum.sum()
  end

  defp pair_galaxies(galaxy_map) do
    galaxies = for {row, row_idx} <- Enum.with_index(galaxy_map), {letter, col_idx} <- Enum.with_index(row),
      letter == "#" do
      %Point2D{x: row_idx, y: col_idx}
    end

    for galaxy1 <- galaxies, galaxy2 <- galaxies, galaxy1 != galaxy2 do
      Enum.min_max([galaxy1, galaxy2])
    end
    |> MapSet.new()
  end

  defp find_void(galaxy_map) do
    void_rows = Enum.with_index(galaxy_map)
    |> Enum.filter(fn {row, _} -> Enum.all?(row, &(&1 == ".")) end)
    |> Enum.map(fn {_, row_idx} -> row_idx end)

    width = Enum.count(hd(galaxy_map))
    void_cols = Enum.filter(0..width-1, fn col ->
      Enum.map(galaxy_map, fn row -> Enum.at(row, col) end)
      |> Enum.all?(&(&1 == "."))
    end)

    {void_rows, void_cols}
  end

  defp count_void(void_line_nos, line_no1, line_no2) do
    {lower, higher} = Enum.min_max([line_no1, line_no2])
    Enum.filter(void_line_nos, fn line_no -> lower < line_no and higher > line_no end)
    |> Enum.count()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn line -> String.graphemes(line) end)
  end
end
