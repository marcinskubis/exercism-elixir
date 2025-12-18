
defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []

  def tick(matrix) do
    rows = length(matrix)
    cols = if rows == 0, do: 0, else: length(List.first(matrix))

    for i <- 0..(rows - 1) do
      for j <- 0..(cols - 1) do
        current = Enum.at(Enum.at(matrix, i), j)
        neighbors = count_neighbors(matrix, i, j, rows, cols)

        cond do
          current == 1 and (neighbors == 2 or neighbors == 3) -> 1

          current == 0 and neighbors == 3 -> 1

          true -> 0
        end
      end
    end
  end

  defp count_neighbors(matrix, i, j, rows, cols) do
    deltas = [-1, 0, 1]

    Enum.reduce(deltas, 0, fn di, acc_i ->
      acc_i +
        Enum.reduce(deltas, 0, fn dj, acc_j ->
          if di == 0 and dj == 0 do
            acc_j
          else
            acc_j + live?(matrix, i + di, j + dj, rows, cols)
          end
        end)
    end)
  end

  defp live?(matrix, i, j, rows, cols) do
    if i >= 0 and i < rows and j >= 0 and j < cols do
      case Enum.at(Enum.at(matrix, i), j) do
        1 -> 1
        _ -> 0
      end
    else
      0
    end
  end
end