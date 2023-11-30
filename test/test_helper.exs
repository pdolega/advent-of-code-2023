ExUnit.start(exclude: [:skip])

defmodule TestUtil do
  def read_input file do
    Path.join(:code.priv_dir(:advent_of_code_2023), file)
      |> File.read!
  end
end
