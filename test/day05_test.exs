import Day05

defmodule Day05Test do
  use ExUnit.Case

  doctest Day05

  setup_all do
    test_input =  """
                  seeds: 79 14 55 13

                  seed-to-soil map:
                  50 98 2
                  52 50 48

                  soil-to-fertilizer map:
                  0 15 37
                  37 52 2
                  39 0 15

                  fertilizer-to-water map:
                  49 53 8
                  0 11 42
                  42 0 7
                  57 7 4

                  water-to-light map:
                  88 18 7
                  18 25 70

                  light-to-temperature map:
                  45 77 23
                  81 45 19
                  68 64 13

                  temperature-to-humidity map:
                  0 69 1
                  1 0 69

                  humidity-to-location map:
                  60 56 37
                  56 93 4\
                  """

    real_input = TestUtil.read_input("day05.txt")

    {:ok, %{test_input: test_input, real_input: real_input}}
  end

  test "part1 - test input", %{test_input: test_input} do
    assert part1(test_input) == 35
  end

  test "part1 - real input", %{real_input: real_input} do
    assert part1(real_input) == 318_728_750
  end

  test "part2 - test input", %{test_input: test_input} do
    assert part2(test_input) == 46
  end


  test "part2 - real input", %{real_input: real_input} do
    assert part2(real_input) == 37_384_986
  end
end
