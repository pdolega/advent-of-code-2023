import Day06

defmodule Day06Test do
  use ExUnit.Case

  doctest Day06

  setup_all do
    test_input =  """
                  Time:      7  15   30
                  Distance:  9  40  200\
                  """

    real_input = TestUtil.read_input("day06.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 288
  end


  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 2_269_432
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == 71_503
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 35_865_985
  end
end
