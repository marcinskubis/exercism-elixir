defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&letter_score/1)
    |> Enum.sum()
  end

  defp letter_score(letter) do
    cond do
      letter in ~w(A E I O U L N R S T) -> 1
      letter in ~w(D G) -> 2
      letter in ~w(B C M P) -> 3
      letter in ~w(F H V W Y) -> 4
      letter == "K" -> 5
      letter in ~w(J X) -> 8
      letter in ~w(Q Z) -> 10
      true -> 0
    end
  end
end