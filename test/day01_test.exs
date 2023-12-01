defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  setup_all do
    test_input1 = """
                  1abc2
                  pqr3stu8vwx
                  a1b2c3d4e5f
                  treb7uchet\
                  """

    test_input2 = """
                  two1nine
                  eightwothree
                  abcone2threexyz
                  xtwone3four
                  4nineeightseven2
                  zoneight234
                  7pqrstsixteen\
                  """

    real_input = TestUtil.read_input("day01.txt")

    {:ok, %{test_input1: test_input1, test_input2: test_input2, real_input: real_input}}
  end

  test "sum calibration with simple digits - test input", %{test_input1: test_input} do
    assert Day01.sum_calibration_num(test_input) == 142
  end

  test "sum calibration with simple digits - real input", %{real_input: real_input} do
    assert Day01.sum_calibration_num(real_input) == 56_506
  end

  test "sum calibration with string digits - test input", %{test_input2: test_input} do
    assert Day01.sum_calibration_num_text(test_input) == 281
  end

  test "sum calibration with string digits", %{real_input: real_input} do
    assert Day01.sum_calibration_num_text(real_input) == 56_017
  end
end
