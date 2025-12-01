
defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) when num <= 0, do: []

  def rows(num) do
    Enum.reduce(1..num, [], fn _, acc ->
      case acc do
        [] ->
          [[1]]

        prev_rows ->
          last_row = List.last(prev_rows)
          new_row = build_row(last_row)
          prev_rows ++ [new_row]
      end
    end)
  end

  defp build_row(prev_row) do
    middle =
      Enum.chunk_every(prev_row, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> a + b end)

    [1] ++ middle ++ [1]
  end
end
