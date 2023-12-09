defmodule Day08 do
  def part1(input) do
    {dirs, positions} = parse_input(input)

    Stream.cycle(dirs)
    |> Enum.reduce_while({0, "AAA"}, fn dir, {counter, current_position} ->
      if current_position == "ZZZ" do
        {:halt, counter}
      else
        {left, right} = Map.get(positions, current_position)
        new_position = case dir do
          "L" -> left
          "R" -> right
        end

        {:cont, {counter + 1, new_position}}
      end
    end)
  end

  def part2(input) do
    {dirs, positions} = parse_input(input)

    start_positions = Map.keys(positions)
    |> Enum.filter(fn pos ->
      String.slice(pos, -1, 1) == "A"
    end)

    Stream.cycle(dirs)
    |> Enum.reduce_while({0, start_positions, %{}}, fn dir, {counter, current_positions, z_freqs} ->
      new_z_freqs = Enum.with_index(current_positions)
      |> Enum.filter(fn {pos, _} -> String.slice(pos, -1, 1) == "Z" end)
      |> Enum.reduce(z_freqs, fn {pos, idx}, z_freqs ->
         case Map.get(z_freqs, idx) do
          nil -> Map.put(z_freqs, idx, counter)
          _ -> z_freqs
        end
      end)

      if Enum.count(new_z_freqs) == Enum.count(start_positions) do
        {:halt, new_z_freqs}
      else
        new_positions = Enum.map(current_positions, fn current_position ->
          {left, right} = Map.get(positions, current_position)
          case dir do
            "L" -> left
            "R" -> right
          end
        end)
        {:cont, {counter + 1, new_positions, new_z_freqs}}
      end
    end)
    |> Map.values()
    |> lcm()
  end

  defp lcm(z_freqs) do
    Enum.reduce(z_freqs, fn freq, prev ->
      trunc(Enum.reduce([freq, prev], &(&1 * &2)) / Integer.gcd(freq, prev))
    end)
  end

  defp parse_input(input) do
    [directions, _ | positions] = String.split(input, "\n")
    dirs = String.graphemes(directions)

    positions = Enum.map(positions, fn pos ->
      [_ | rest] = Regex.run(~r/([[:alnum:]]+) = \(([[:alnum:]]+), ([[:alnum:]]+)\)/, pos)
      List.to_tuple(rest)
    end)
    |> Map.new(fn {pos, left, right} ->
      {pos, {left, right}}
    end)

    {dirs, positions}
  end
end
