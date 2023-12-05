import Day04

defmodule Day04Test do
  use ExUnit.Case

  doctest Day04

  setup_all do
    test_input =  """
                  Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
                  Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
                  Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
                  Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
                  Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
                  Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11\
                  """

    real_input = TestUtil.read_input("day04.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 13
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 22_193
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == 30
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 5_625_994
  end
end
