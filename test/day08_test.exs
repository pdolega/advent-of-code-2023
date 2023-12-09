import Day08

defmodule Day08Test do
  use ExUnit.Case
  @moduletag timeout: :infinity

  doctest Day08

  setup_all do
    test_input1 =  """
                  LLR

                  AAA = (BBB, BBB)
                  BBB = (AAA, ZZZ)
                  ZZZ = (ZZZ, ZZZ)\
                  """

    test_input2 =  """
                  LR

                  11A = (11B, XXX)
                  11B = (XXX, 11Z)
                  11Z = (11B, XXX)
                  22A = (22B, XXX)
                  22B = (22C, 22C)
                  22C = (22Z, 22Z)
                  22Z = (22B, 22B)
                  XXX = (XXX, XXX)\
                  """

    real_input = TestUtil.read_input("day08.txt")

    {:ok, %{test_input1: test_input1, test_input2: test_input2, real_input: real_input}}
  end


  test "part1 - test input", %{test_input1: test_input} do
    assert part1(test_input) == 6
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 20_569
  end

  test "part2 - test input", %{test_input2: test_input} do
    assert part2(test_input) == 6
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 21_366_921_060_721
  end
end
