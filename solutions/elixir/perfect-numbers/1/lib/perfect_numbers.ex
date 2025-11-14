defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number > 0 do
    sum = aliquot_sum(number)

    cond do
      sum == number -> {:ok, :perfect}
      sum > number -> {:ok, :abundant}
      sum < number -> {:ok, :deficient}
    end
  end

  def classify(_), do: {:error, "Classification is only possible for natural numbers."}
  
  defp aliquot_sum(1), do: 0
  
  defp aliquot_sum(n) do
    # Only iterate up to sqrt(n) to find factor pairs
    limit = trunc(:math.sqrt(n))
    
    1..limit
    |> Enum.reduce(0, fn i, acc ->
      if rem(n, i) == 0 do
        divisor = div(n, i)
        cond do
          # If i is 1, add it
          i == 1 -> acc + 1
          # If i and divisor are the same (perfect square), add only once
          i == divisor -> acc + i
          # If divisor is n itself, don't add it (only add i)
          divisor == n -> acc + i
          # Otherwise add both i and its pair divisor
          true -> acc + i + divisor
        end
      else
        acc
      end
    end)
  end
end