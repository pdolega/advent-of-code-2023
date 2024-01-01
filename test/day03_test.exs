import Day03

defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  setup_all do
    test_input =  """
                  467..114..
                  ...*......
                  ..35..633.
                  ......#...
                  617*......
                  .....+.58.
                  ..592.....
                  ......755.
                  ...$.*....
                  .664.598..\
                  """

    real_input = TestUtil.read_input("day03.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "calculasum part numberste1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 4_361

    assert part1("""
                ...*145
                .......
                .......
                """) == 145
  end

  test "sum part numbers - real input", %{real_input: real_input} do
    assert part1(real_input) == 530_495
  end

  test "sum gear ratios - test input", %{test_input: test_input} do
    assert part2(test_input) == 467_835
  end

  test "sum gear ratios - real input", %{real_input: real_input} do
    assert part2(real_input) == 80_253_814
  end
end
