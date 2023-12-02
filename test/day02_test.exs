import Day02

defmodule Day02Test do
  use ExUnit.Case

  doctest Day02

  setup_all do
    test_input =  """
                  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
                  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
                  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
                  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
                  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green\
                  """

    real_input = TestUtil.read_input("day02.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "sum possible games - test input", %{test_input: test_input} do
    assert sum_possible_games(test_input) == 8
  end

  test "sum_possible_games - real input", %{real_input: real_input} do
    assert sum_possible_games(real_input) == 2_810
  end

  test "multiply minimal sets - test input", %{test_input: test_input} do
    assert multiply_min_sets(test_input) == 2_286
  end

  test "multiply minimal sets - real input", %{real_input: real_input} do
    assert multiply_min_sets(real_input) == 69_110
  end
end
