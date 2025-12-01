defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factorize(number, 2, [])
  end

  defp factorize(1, _divisor, factors), do: Enum.reverse(factors)

  defp factorize(number, divisor, factors) when divisor * divisor > number do
    # If divisor squared is greater than number, number itself is prime
    Enum.reverse([number | factors])
  end

  defp factorize(number, divisor, factors) do
    if rem(number, divisor) == 0 do
      # divisor is a factor, divide and continue with same divisor
      factorize(div(number, divisor), divisor, [divisor | factors])
    else
      # divisor is not a factor, try next divisor
      factorize(number, divisor + 1, factors)
    end
  end
end