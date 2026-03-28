
defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) when num <= 0, do: []

  def rows(num) do
    1..num
    |> Enum.reduce([], fn _, acc ->
      case acc do
        [] ->
          [[1] | acc]

        [last_row | _] ->
          new_row = build_row(last_row)
          [new_row | acc]
      end
    end)
    |> Enum.reverse()
  end

  defp build_row(prev_row) do
    middle =
      prev_row
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] -> a + b end)

    [1 | middle] |> prepend_last(1)
  end

  defp prepend_last(list, item) do
    Enum.reverse([item | Enum.reverse(list)])
  end
end
