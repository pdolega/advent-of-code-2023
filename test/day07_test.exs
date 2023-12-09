import Day07

defmodule Day07Test do
  use ExUnit.Case

  doctest Day07

  setup_all do
    test_input =  """
                  32T3K 765
                  T55J5 684
                  KK677 28
                  KTJJT 220
                  QQQJA 483\
                  """

    real_input = TestUtil.read_input("day07.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 6440
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 250_474_325
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == 5905
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 248_909_434
  end
end
