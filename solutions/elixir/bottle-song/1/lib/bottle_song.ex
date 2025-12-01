defmodule BottleSong do
  @spec recite(integer, integer) :: String.t()
  def recite(start_bottles, take_down) do
    start_bottles..(start_bottles - take_down + 1)
    |> Enum.map(&verse/1)
    |> Enum.join("\n\n")
  end

  defp verse(n) do
    """
    #{bottles(n, true)} hanging on the wall,
    #{bottles(n, true)} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{bottles(n - 1, false)} hanging on the wall.\
    """
  end

  defp bottles(0, _capitalize), do: "no green bottles"
  defp bottles(1, capitalize), do: "#{if capitalize, do: "One", else: "one"} green bottle"
  defp bottles(n, capitalize), do: "#{number_word(n, capitalize)} green bottles"

  defp number_word(n, true), do: String.capitalize(number_word(n, false))
  defp number_word(2, false), do: "two"
  defp number_word(3, false), do: "three"
  defp number_word(4, false), do: "four"
  defp number_word(5, false), do: "five"
  defp number_word(6, false), do: "six"
  defp number_word(7, false), do: "seven"
  defp number_word(8, false), do: "eight"
  defp number_word(9, false), do: "nine"
  defp number_word(10, false), do: "ten"
end