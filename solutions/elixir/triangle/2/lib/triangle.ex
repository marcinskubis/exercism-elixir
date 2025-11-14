defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    positive = (a > 0 and b > 0 and c > 0)
    inequality = (a + b >= c) and (b + c >= a) and (a + c >= b)
    cond do
      not positive -> {:error, "all side lengths must be positive"}
      not inequality -> {:error, "side lengths violate triangle inequality"}
      a == b and b == c -> {:ok, :equilateral}
      a == b or b == c or a == c -> {:ok, :isosceles}
      true -> {:ok, :scalene}
    end
  end
end
