defmodule Day05 do
  defmodule IntervalMapping do
    defstruct original: {-1, -1}, mapped: []
  end

  def part1(input) do
    {original_seeds, conversions} = parse_input(input)

    Enum.map(original_seeds, fn s -> {s, 1} end)
    |> perform_mapping(conversions)
  end

  def part2(input) do
    {original_seeds, conversions} = parse_input(input)

    Enum.chunk_every(original_seeds, 2)
    |> Enum.map(fn s -> List.to_tuple(s) end)
    |> perform_mapping(conversions)
  end

  defp perform_mapping(seed_ranges, conversion_stages) do
    Enum.reduce(Tuple.to_list(conversion_stages), seed_ranges, fn mapping, source_ranges ->
      Enum.flat_map(source_ranges, fn s -> map_source_to_dest(s, mapping) end)
    end)
    |> Enum.map(fn {start, _} -> start end)
    |> Enum.min()
  end

  defp map_source_to_dest({src_start, src_length}, conversion_map) do
    mapped_intervals = Enum.reduce(conversion_map, [], fn {map_dst_start, map_src_start, map_length}, mapped ->
      src_end = src_start + src_length - 1
      map_src_end = map_src_start + map_length - 1

      cond do
        map_src_start > src_end or map_src_end < src_start -> # src outside of map
          mapped

        src_start >= map_src_start and src_end <= map_src_end -> # src inside
          if not Enum.empty?(mapped) do raise "src_interval is not empty" end
          [{src_start, map_dst_start + (src_start - map_src_start), src_length}]

          src_start < map_src_start and src_end > map_src_end -> # src covers whole map
            [{map_src_start, map_dst_start, map_length} | mapped]

          src_start < map_src_start and src_end <= map_src_end -> # src overlaps from the left
            mapped_length = src_end - map_src_start + 1
            [{map_src_start, map_dst_start, mapped_length} | mapped]

          src_start <= map_src_end and src_end > map_src_end -> # src overlaps from the right
            mapped_start = map_dst_start + (src_start - map_src_start)
            mapped_length = map_src_end - src_start + 1
            [{src_start, mapped_start, mapped_length} | mapped]
      end
    end)

    reconcile_intervals(%IntervalMapping{
      original: {src_start, src_length},
      mapped: mapped_intervals
    })
  end

  defp reconcile_intervals(%IntervalMapping{original: original_interval, mapped: mapped}) do
    Enum.sort_by(mapped, fn {src_start, _, _} -> src_start end)
    |> fill_edge_gaps(original_interval)
    |> fill_internal_gaps()
    |> Enum.map(fn {_, dst_start, length} -> {dst_start, length} end)
  end

  defp fill_edge_gaps(mapped_intervals, original_interval) do
    {original_start, original_length} = original_interval

    original_end = original_start + original_length - 1
    case mapped_intervals do
      [] -> # no mapped region
        [{original_start, original_start, original_length}]

      [{first_start, _, _} | _] when first_start != original_start -> # mapped region doesn't start at the beginnning
        [{original_start, original_start, first_start - original_start} | mapped_intervals]

      _ ->
        {last_start, _, last_length} = List.last(mapped_intervals)
        last_end = last_start + last_length - 1

        if last_end != original_end do # mapped regions have a gap by the end of original interval
          [{last_end + 1, last_end + 1, original_end - last_end} | mapped_intervals]
        else
          mapped_intervals
        end
    end
  end

  defp fill_internal_gaps(mapped_intervals) do
    Enum.reduce(mapped_intervals, [], fn sub_interval = {src_start, dst_start, length}, result ->
      case result do
        [] -> # there is no prior interval
          [{src_start, dst_start, length}]

        # there is a gap between the prior interval and the current interval
        [{last_src_start, _, last_length} | _] when last_src_start + last_length < src_start ->
          missing_start = last_src_start + last_length
          missing_length = src_start - missing_start
          [{missing_start, missing_start, missing_length}, sub_interval | result]

        _ -> # there is no gap between the prior and the current interval
          [sub_interval | result]
      end
    end)
  end

  defp parse_input(input) do
    [original_seeds_line | rest] = String.split(input, "\n")

    [_, str_nums] = String.split(original_seeds_line, ": ")
    original_seeds = String.split(str_nums, " ")
    |> Enum.map(&String.to_integer/1)

    conversions = Enum.chunk_by(rest, fn line -> line == "" end)
    |> Enum.filter(fn line -> line != [""] end)
    |> Enum.map(fn [_ | lines] -> lines end) # cut header lines
    |> Enum.map(fn conversion ->
      Enum.map(conversion, fn c ->
        String.split(c, " ")
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)
    end)
    |> List.to_tuple()

    {original_seeds, conversions}
  end
end
