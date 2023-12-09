import Day10

defmodule Day10Test do
  use ExUnit.Case
  @moduletag timeout: :infinity

  doctest Day10

  setup_all do
    test_input =  """

                  """

    real_input = TestUtil.read_input("day10.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == :ok
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == :ok
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == :ok
  end

  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == :ok
  end
end
