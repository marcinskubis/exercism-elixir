
defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when is_integer(number) and number >= 0 and number <= 999_999_999_999 do
    {:ok, convert(number)}
  end

  def in_english(_), do: {:error, "number is out of range"}

  # Main conversion logic
  defp convert(0), do: "zero"
  defp convert(n), do: do_convert(n)

  defp do_convert(n) do
    cond do
      n >= 1_000_000_000 -> group(n, 1_000_000_000, "billion")
      n >= 1_000_000 -> group(n, 1_000_000, "million")
      n >= 1_000 -> group(n, 1_000, "thousand")
      true -> convert_hundreds(n)
    end
  end

  defp group(n, divisor, name) do
    left = div(n, divisor)
    right = rem(n, divisor)

    result = "#{convert_hundreds(left)} #{name}"
    if right > 0, do: result <> " " <> do_convert(right), else: result
  end

  defp convert_hundreds(n) do
    cond do
      n >= 100 ->
        hundreds = div(n, 100)
        rest = rem(n, 100)
        if rest > 0, do: "#{ones(hundreds)} hundred #{convert_tens(rest)}", else: "#{ones(hundreds)} hundred"

      true -> convert_tens(n)
    end
  end

  defp convert_tens(n) do
    cond do
      n < 20 -> ones(n)
      true ->
        tens_digit = div(n, 10)
        rest = rem(n, 10)
        tens_word = tens(tens_digit)
        if rest > 0, do: "#{tens_word}-#{ones(rest)}", else: tens_word
    end
  end

  defp ones(n) do
    case n do
      0 -> ""
      1 -> "one"
      2 -> "two"
      3 -> "three"
      4 -> "four"
      5 -> "five"
      6 -> "six"
      7 -> "seven"
      8 -> "eight"
      9 -> "nine"
      10 -> "ten"
      11 -> "eleven"
      12 -> "twelve"
      13 -> "thirteen"
      14 -> "fourteen"
      15 -> "fifteen"
      16 -> "sixteen"
      17 -> "seventeen"
      18 -> "eighteen"
      19 -> "nineteen"
    end
  end

  defp tens(n) do
    case n do
      2 -> "twenty"
      3 -> "thirty"
      4 -> "forty"
      5 -> "fifty"
      6 -> "sixty"
      7 -> "seventy"
      8 -> "eighty"
      9 -> "ninety"
    end
  end
end
