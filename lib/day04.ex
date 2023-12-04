defmodule Day04 do
  def part1(input) do
    nums = parse_input(input)

    Enum.map(nums, fn {card_nums, my_nums} ->
      winning_nums = MapSet.intersection(MapSet.new(card_nums), MapSet.new(my_nums))
      case Enum.count(winning_nums) do
        0 -> 0
        num -> :math.pow(2, num - 1)
      end
    end)
    |> Enum.sum()
  end

  def part2(input) do
    scratchcards = parse_input(input)
    |> Enum.with_index(1)
    |> Enum.map(fn {scratchard, index} -> {index, scratchard} end)

    won_cards = Enum.map(scratchcards, fn {index, _} -> {index, 0} end)
    |> Enum.into(%{})

    new_scratchcards = Enum.reduce(scratchcards, won_cards, fn {index, scratchcard}, won_scratchcards ->
      {card_nums, my_nums} = scratchcard
      winning_nums = MapSet.intersection(MapSet.new(card_nums), MapSet.new(my_nums))

      copies_count = Map.get(won_scratchcards, index)

      case Enum.count(winning_nums) do
        0 ->
          won_scratchcards

        won_count ->
          Enum.reduce(index+1..index+won_count, won_scratchcards, fn num, new_scratchcards ->
            Map.update(new_scratchcards, num, copies_count + 1, fn count -> count + copies_count + 1 end)
          end)
      end
    end)

    new_scratchcard_sum = Map.values(new_scratchcards)
    |> Enum.sum()

    new_scratchcard_sum + Enum.count(scratchcards)
  end

  defp parse_input(input) do
    nums_regex = ~r/(\d+)/

    String.split(input, "\n")
    |> Enum.map(fn line ->
      [nums_on_card, my_nums] = String.split(line, "|")
      [_, nums_on_card] = String.split(nums_on_card, ":")

      nums_left = Regex.scan(nums_regex, nums_on_card)
      |> Enum.map(fn [_, num] -> String.to_integer(num) end)

      nums_right = Regex.scan(nums_regex, my_nums)
      |> Enum.map(fn [_, num] -> String.to_integer(num) end)

      {nums_left, nums_right}
    end)
  end
end
