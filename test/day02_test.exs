import Day02

defmodule Day02Test do
  use ExUnit.Case
  @moduletag timeout: :infinity

  doctest Day02

  setup_all do
    test_input =  """

                  """

    real_input = TestUtil.read_input("day02.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  @tag :skip
  test "calculate1 - test input", %{test_input: test_input} do
    assert calculate1(test_input) == :ok
  end

  @tag :skip
  test "calculate1 - real input", %{real_input: real_input} do
    assert calculate1(real_input) == :ok
  end

  @tag :skip
  test "calculate2 - test input", %{test_input: test_input} do
    assert calculate2(test_input) == :ok
  end

  @tag :skip
  test "calculate2 - real input", %{real_input: real_input} do
    assert calculate2(real_input) == :ok
  end
end
