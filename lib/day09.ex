defmodule Day09 do
  def part1(input) do
    lines = parse_input(input)

    Enum.map(lines, fn line ->

      diffs = Stream.unfold(line, fn line ->
        diffs = Enum.chunk_every(line, 2, 1, :discard)
        |> Enum.map(fn [a, b] ->
          b - a
        end)

        {diffs, diffs}
      end)
      |> Enum.take_while(fn diffs ->
        not Enum.all?(diffs, &(&1 == 0))
      end)


      diff = Enum.reverse(diffs)
      |> Enum.map(fn diff_stage ->
        Enum.reverse(diff_stage)
        |> hd()
      end)
      |> Enum.reduce(0, &(&1 + &2))

      [last | _] = Enum.reverse(line)
      last + diff


    end)
    |> Enum.sum()

  end

  def part2(input) do
    lines = parse_input(input)

    Enum.map(lines, fn line ->

      diffs = Stream.unfold(line, fn line ->
        diffs = Enum.chunk_every(line, 2, 1, :discard)
        |> Enum.map(fn [a, b] ->
          b - a
        end)

        {diffs, diffs}
      end)
      |> Enum.take_while(fn diffs ->
        not Enum.all?(diffs, &(&1 == 0))
      end)


      diff = Enum.reverse(diffs)
      |> Enum.map(fn diff_stage ->
        hd(diff_stage)
      end)
      |> Enum.reduce(&(&1 - &2))

      [first | _] = line
      first - diff

    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn line ->
      String.split(line, " ") |> Enum.map(&String.to_integer/1)
    end)
  end
end
