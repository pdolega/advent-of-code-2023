defmodule Day07 do

  defmodule GenericComparator do
    def compare({cards1, _}, {cards2, _}, card_hierarchy, count_func) do
      {count1, count2} = {count_func.(cards1), count_func.(cards2)}

      if count1 == count2 do # same types in both hands
        first_diff = Enum.zip(
          map_hierarchy_positions(cards1, card_hierarchy),
          map_hierarchy_positions(cards2, card_hierarchy)
        )
        |> Enum.find(fn {o1, o2} -> o1 != o2 end)

        case first_diff do
          {o1, o2} when o1 > o2 -> :gt
          {o1, o2} when o1 < o2 -> :lt
          nil -> :eq
        end
      else  # differnt types in both hands
        {c1, c2} = Enum.zip(count1, count2)
        |> Enum.find(fn {c1, c2} -> c1 != c2 end)

        case {c1, c2} do
          {c1, c2} when c1 > c2 -> :gt
          {c1, c2} when c1 < c2 -> :lt
          _ -> :eq
        end
      end
    end

    defp map_hierarchy_positions(cards, card_hierarchy) do
      Enum.map(cards, fn card ->
        {_, idx} = Enum.find(card_hierarchy, fn {c, _} -> c == card end)
        idx
      end)
    end
  end

  defmodule RegularComparator do
    @order  Enum.reverse(["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]) |> Enum.with_index()

    def compare(hand1, hand2) do
      GenericComparator.compare(hand1, hand2, @order, &get_type/1)
    end

    defp get_type(cards) do
      Enum.group_by(cards, &(&1), &(&1))
      |> Map.new(fn {card, list} -> {card, Enum.count(list)} end)
      |> Map.values()
      |> Enum.sort(:desc)
    end
  end

  defmodule JokerComparator do
    @order  Enum.reverse(["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]) |> Enum.with_index()

    @spec compare({any(), any()}, {any(), any()}) :: :eq | :gt | :lt
    def compare(hand1, hand2) do
      GenericComparator.compare(hand1, hand2, @order, &get_type/1)
    end

    defp get_type(cards) do
      original_card_count = Enum.group_by(cards, &(&1), &(&1))
      |> Map.new(fn {card, list} -> {card, Enum.count(list)} end)

      jokers_no = Map.get(original_card_count, "J", 0)
      card_types = Map.delete(original_card_count, "J")

      case jokers_no do
        0 -> card_types
        5 -> %{hd(@order) => 5}
        jokers_no ->
          {card, num} = get_joker_equivalent(card_types)
          Map.put(card_types, card, num + jokers_no)
      end
      |> Map.values()
      |> Enum.sort(:desc)
    end

    defp get_joker_equivalent(card_types) do
      {_, highest_num} = Enum.max_by(card_types, fn {_, num} -> num end)

      highest_cards = Enum.filter(card_types, fn {_, num} -> num == highest_num end)
      |> Enum.map(fn {card, _} -> card end)

      highest_card = case highest_cards do
        [card] -> card
        _ ->
          Enum.max_by(highest_cards, fn card ->
            {_, idx} = Enum.find(@order, fn {c, _} -> c == card end)
            idx
          end)
      end

      {highest_card, highest_num}
    end
  end

  def part1(input) do
    sum_bets(input, RegularComparator)
  end

  def part2(input) do
    sum_bets(input, JokerComparator)
  end

  def sum_bets(input, comparator_mod) do
    parse_input(input)
    |> Enum.sort({:asc, comparator_mod})
    |> Enum.map(fn {_, bet} -> bet end)
    |> Enum.with_index(1)
    |> Enum.map(fn {bet, idx} -> bet * idx end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn line ->
      [hand, bet] = String.split(line, " ")
      {String.graphemes(hand), String.to_integer(bet)}
    end)
  end
end
