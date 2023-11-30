defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  setup_all do
    test_input = """
                 199
                 200
                 208
                 210
                 200
                 207
                 240
                 269
                 260
                 263\
                 """

    real_input = TestUtil.read_input("day01.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "count depth increases - test input", %{test_input: test_input} do
    assert Day01.count_depth_increases(test_input) == 7
  end

  @tag :skip
  test "count depth increases - real input", %{real_input: real_input} do
    assert Day01.count_depth_increases(real_input) == 1_215
  end

  test "count depth changes in triples - test input", %{test_input: test_input} do
    assert Day01.count_depth_triples(test_input) == 5
  end

  @tag :skip
  test "count depth changes in triples - real input", %{real_input: real_input} do
    assert Day01.count_depth_triples(real_input) == 1_150
  end
end
