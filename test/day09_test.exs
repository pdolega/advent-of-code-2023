import Day09

defmodule Day09Test do
  use ExUnit.Case

  doctest Day09

  setup_all do
    test_input =  """
                  0 3 6 9 12 15
                  1 3 6 10 15 21
                  10 13 16 21 30 45\
                  """

    real_input = TestUtil.read_input("day09.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 114
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 1_842_168_671
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == 2
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 903
  end
end
