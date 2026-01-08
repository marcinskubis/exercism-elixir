defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true

  def chain?(dominoes) do
    {degrees, adjacency} =
      Enum.reduce(dominoes, {%{}, %{}}, fn {a, b}, {deg, adj} ->
        deg =
          if a == b do
            deg
            |> Map.update(a, 2, &(&1 + 2))
          else
            deg
            |> Map.update(a, 1, &(&1 + 1))
            |> Map.update(b, 1, &(&1 + 1))
          end

        adj =
          if a == b do
            adj
            |> Map.update(a, MapSet.new([a]), &MapSet.put(&1, a))
          else
            adj
            |> Map.update(a, MapSet.new([b]), &MapSet.put(&1, b))
            |> Map.update(b, MapSet.new([a]), &MapSet.put(&1, a))
          end

        {deg, adj}
      end)

    vertices = Map.keys(degrees)

    all_even? = Enum.all?(degrees, fn {_v, d} -> rem(d, 2) == 0 end)

    connected? =
      case vertices do
        [] ->
          true

        [start | _] ->
          visited = dfs(adjacency, start, MapSet.new())
          MapSet.size(visited) == length(vertices)
      end

    all_even? and connected?
  end

  defp dfs(adjacency, v, visited) do
    if MapSet.member?(visited, v) do
      visited
    else
      neighbors = Map.get(adjacency, v, MapSet.new())
      visited1 = MapSet.put(visited, v)

      Enum.reduce(neighbors, visited1, fn n, acc ->
        dfs(adjacency, n, acc)
      end)
    end
  end
end