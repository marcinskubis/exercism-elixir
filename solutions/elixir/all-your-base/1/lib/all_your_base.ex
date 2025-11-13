defmodule AllYourBase do
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, fn d -> d < 0 or d >= input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        digits
        |> drop_leading_zeros()
        |> to_decimal(input_base)
        |> from_decimal(output_base)
        |> then(&{:ok, &1})
    end
  end

  defp drop_leading_zeros([]), do: []
  defp drop_leading_zeros(digits) do
    Enum.drop_while(digits, &(&1 == 0))
  end

  defp to_decimal([], _base), do: 0
  defp to_decimal(digits, base) do
    Enum.reduce(digits, 0, fn d, acc -> acc * base + d end)
  end

  defp from_decimal(0, _base), do: [0]
  defp from_decimal(n, base), do: do_from_decimal(n, base, [])

  defp do_from_decimal(0, _base, acc), do: acc
  defp do_from_decimal(n, base, acc) do
    do_from_decimal(div(n, base), base, [rem(n, base) | acc])
  end
end