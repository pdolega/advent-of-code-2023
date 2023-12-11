import Day11

defmodule Day11Test do
  use ExUnit.Case

  doctest Day11

  setup_all do
    test_input =  """
                  ...#......
                  .......#..
                  #.........
                  ..........
                  ......#...
                  .#........
                  .........#
                  ..........
                  .......#..
                  #...#.....\
                  """

    real_input = TestUtil.read_input("day11.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 374
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 9_370_588
  end


  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input, 10) == 1_030
    assert part2(test_input, 100) == 8410
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input, 1_000_000) == 746_207_878_188
  end
end
