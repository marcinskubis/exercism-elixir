
defmodule Garden do
  @default_names [
    :alice, :bob, :charlie, :david, :eve, :fred,
    :ginny, :harriet, :ileana, :joseph, :kincaid, :larry
  ]

  @doc """
  Build a map containing each child's plants based on the diagram.

  - `diagram` is a two-line string: first line is the row nearest the window.
  - `names` is an optional list of atom names; defaults to the 12 class names.
  - Returns a map with atom keys for each child, values are 4-element tuples of plant atoms.
    Students beyond capacity get `{}`.
  """
  def info(diagram, names \\ @default_names) do
    [row1, row2] = String.split(diagram, "\n", trim: true)
    cups1 = String.graphemes(row1)
    cups2 = String.graphemes(row2)
    capacity = div(length(cups1), 2)

    names
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {name, idx} ->
      if idx < capacity do
        base = idx * 2

        {name,
         {
           to_plant(Enum.at(cups1, base)),
           to_plant(Enum.at(cups1, base + 1)),
           to_plant(Enum.at(cups2, base)),
           to_plant(Enum.at(cups2, base + 1))
         }}
      else
        {name, {}}
      end
    end)
    |> Map.new()
  end

  # --- helpers ---

  defp to_plant("G"), do: :grass
  defp to_plant("C"), do: :clover
  defp to_plant("R"), do: :radishes
  defp to_plant("V"), do: :violets
end
