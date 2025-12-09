
defmodule School do
  @doc """
  Create a new, empty school roster.
  """
  def new, do: %{}

  @doc """
  Add a `student` to a `grade`.

  Returns:
    - `{:ok, updated_school}` if the student was added.
    - `{:error, school}` if the student already exists in any grade.
  """
  def add(school, student, grade) when is_binary(student) and is_integer(grade) do
    if student_in_school?(school, student) do
      {:error, school}
    else
      updated =
        Map.update(school, grade, MapSet.new([student]), fn set ->
          MapSet.put(set, student)
        end)

      {:ok, updated}
    end
  end

  @doc """
  Return the full roster: students sorted by grade (ascending) and name (alphabetically).
  """
  def roster(school) do
    school
    |> Enum.sort_by(fn {grade, _} -> grade end)
    |> Enum.flat_map(fn {_grade, set} ->
      set |> MapSet.to_list() |> Enum.sort()
    end)
  end

  @doc """
  Return the list of students in a given `grade`, sorted by name.
  """
  def grade(school, grade) do
    case Map.get(school, grade) do
      nil -> []
      set -> set |> MapSet.to_list() |> Enum.sort()
    end
  end

  # ---- helpers ----

  defp student_in_school?(school, student) do
    Enum.any?(school, fn {_grade, set} -> MapSet.member?(set, student) end)
  end
end
