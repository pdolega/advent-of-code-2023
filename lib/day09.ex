defmodule Day09 do
  def part1(input) do
    parse_input(input)
    |> Enum.map(fn line ->
      diff = calculate_diff_stages(line)
      |> Enum.map(fn diff_stage ->
        List.last(diff_stage)
      end)
      |> Enum.reduce(0, &(&1 + &2))

      [last | _] = Enum.reverse(line)
      last + diff
    end)
    |> Enum.sum()
  end

  def part2(input) do
    parse_input(input)
    |> Enum.map(fn line ->
      diff = calculate_diff_stages(line)
      |> Enum.map(fn diff_stage ->
        hd(diff_stage)
      end)
      |> Enum.reduce(&(&1 - &2))

      [first | _] = line
      first - diff
    end)
    |> Enum.sum()
  end

  defp calculate_diff_stages(line) do
    Stream.unfold(line, fn line ->
      diffs = Enum.chunk_every(line, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> b - a end)
      {diffs, diffs}
    end)
    |> Enum.take_while(fn diffs ->
      not Enum.all?(diffs, &(&1 == 0))
    end)
    |> Enum.reverse()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn line ->
      String.split(line, " ") |> Enum.map(&String.to_integer/1)
    end)
  end
end
