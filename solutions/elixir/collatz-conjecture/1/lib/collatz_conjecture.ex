defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  
  @spec calc(pos_integer()) :: non_neg_integer()
  def calc(input) when input > 0 and is_integer(input) do
    do_calc(input, 0)
  end

  # No fallback clause! This ensures invalid inputs raise FunctionClauseError.

  defp do_calc(1, steps), do: steps
  defp do_calc(num, steps) when rem(num, 2) == 0, do: do_calc(div(num, 2), steps + 1)
  defp do_calc(num, steps), do: do_calc(num * 3 + 1, steps + 1)



end
