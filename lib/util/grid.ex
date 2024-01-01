alias Grid.Element

defmodule Grid do

  defmodule Element do
    defstruct row: 0, col: 0, val: nil
  end

  defstruct width: 0, height: 0, grid: []

  def parse(input) do
    lines = String.split(input, "\n")
    |> Enum.map(fn line -> String.graphemes(line) end)

    %Grid{
      width: (if Enum.count(lines) > 0, do: hd(lines) |> Enum.count(), else: 0),
      height: Enum.count(lines),
      grid: lines
    }
  end

  def count(grid) do
    Enum.reduce(grid.grid, 0, fn line, counter ->
      counter + Enum.count(line)
    end)
  end

  def elem(grid, row, col) do
    %Element{row: row, col: col, val: value(grid, row, col)}
  end

  def value(grid, row, col) do
    Enum.at(Enum.at(grid.grid, row), col)
  end

  def adjacent(grid, row, col, :normal) do
    filter_coords(grid, [{row, col - 1}, {row, col + 1}, {row - 1, col}, {row + 1, col}])
    |> Enum.map(fn {row, col} -> elem(grid, row, col) end)
  end

  def adjacent(grid, row, col, :diagonal) do
    diagonal_adjs = filter_coords(grid, [{row - 1, col - 1}, {row - 1, col + 1}, {row + 1, col - 1}, {row + 1, col + 1}])
    |> Enum.map(fn {row, col} -> elem(grid, row, col) end)

    adjacent(grid, row, col, :normal) ++ diagonal_adjs
  end

  def linearize(%Grid{grid: grid}) do
    Enum.with_index(grid)
    |> Enum.reduce([], fn {line, row}, acc ->
      elem_line = Enum.with_index(line)
      |> Enum.map(fn {x, col} ->
        %Element{row: row, col: col, val: x}
      end)

      [elem_line | acc]
    end)
    |> Enum.reverse()
    |> List.flatten()
  end

  defp filter_coords(grid, coords) do
    Enum.filter(coords, fn {row, col} ->
      row >= 0 and row < grid.height and col >= 0 and col < Enum.count(Enum.at(grid.grid, row))
    end)
  end
end

defimpl Enumerable, for: Grid do
  def count(grid) do
    {:ok, Grid.count(grid)}
  end

  def member?(grid, {{row, col}, value}) do
    cond do
      row < 0 or row >= grid.height -> {:error, :out_of_bounds}
      col < 0 or col >= grid.width -> {:error, :out_of_bounds}
      true -> {:ok, Enum.at(Enum.at(grid.grid, row), col) == value}
    end
  end

  def slice(grid) do
    size = Grid.count(grid)

    linearized = Enum.reduce(grid.grid, [], fn line, acc ->
      [line | acc]
    end)
    |> Enum.reverse()
    |> List.flatten()

    {:ok, size, &Enum.slice(linearized, &1, &2)}
  end

  def reduce(_, {:halt, acc}, _), do: {:halted, acc}
  def reduce(grid, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(grid, &1, fun)}

  def reduce(%Grid{grid: _} = grid, {:cont, acc}, fun) do
    reduce(Grid.linearize(grid), {:cont, acc}, fun)
  end
  def reduce([], {:cont, acc}, _), do: {:done, acc}
  def reduce([head | tail], {:cont, acc}, fun), do: reduce(tail, fun.(head, acc), fun)
end
