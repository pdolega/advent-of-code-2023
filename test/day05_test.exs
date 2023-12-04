import Day05

defmodule Day05Test do
  use ExUnit.Case
  @moduletag timeout: :infinity

  doctest Day05

  setup_all do
    test_input =  """

                  """

    real_input = TestUtil.read_input("dayXX.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  @tag :skip
  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == :ok
  end

  @tag :skip
  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == :ok
  end

  @tag :skip
  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == :ok
  end

  @tag :skip
  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == :ok
  end
end
