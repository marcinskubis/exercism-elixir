defmodule Prime do
  @doc """
  Returns the nth prime number.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n > 0 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&prime?/1)
    |> Enum.take(n)
    |> List.last()
  end

  defp prime?(n) when n <= 1, do: false
  defp prime?(2), do: true
  defp prime?(n) when rem(n, 2) == 0, do: false
  defp prime?(n) do
    3..trunc(:math.sqrt(n))//2
    |> Enum.all?(fn i -> rem(n, i) != 0 end)
  end
end