defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    numerals = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]

    Enum.reduce(numerals, {number, ""}, fn {value, symbol}, {n, acc} ->
      count = div(n, value)
      remainder = rem(n, value)
      {remainder, acc <> String.duplicate(symbol, count)}
    end)
    |> elem(1)
  end
end