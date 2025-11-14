defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """
  @spec flatten(list) :: list
  def flatten(list), do: do_flatten(list, []) |> Enum.reverse()

  defp do_flatten([], acc), do: acc

  defp do_flatten([head | tail], acc) when is_list(head) do
    acc = do_flatten(head, acc)
    do_flatten(tail, acc)
  end

  defp do_flatten([head | tail], acc) do
    acc =
      if head != nil do
        [head | acc]
      else
        acc
      end

    do_flatten(tail, acc)
  end
end
