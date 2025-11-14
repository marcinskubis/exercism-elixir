defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(sub, list) when length(sub) > length(list), do: false
  defp sublist?(sub, list) do
    list
    |> Enum.chunk_every(length(sub), 1, :discard)
    |> Enum.any?(fn chunk -> chunk === sub end)
  end
end
