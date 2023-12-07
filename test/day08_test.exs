import Day08

defmodule Day08Test do
  use ExUnit.Case
  @moduletag timeout: :infinity

  doctest Day08

  setup_all do
    test_input =  """

                  """

    real_input = TestUtil.read_input("day08.txt")

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
