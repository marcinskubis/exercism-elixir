defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_down = String.downcase(base)
    sorted_base = sort_letters(base_down)

    Enum.filter(candidates, fn candidate ->
      candidate_down = String.downcase(candidate)
      candidate_down != base_down and sort_letters(candidate_down) == sorted_base
    end)
  end

  defp sort_letters(word) do
    word
    |> String.graphemes()
    |> Enum.sort()
  end
end