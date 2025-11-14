defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) do
    cond do
      number not in 1..64 -> {:error, "The requested square must be between 1 and 64 (inclusive)"}
      true -> {:ok, 2 ** (number - 1)}
    end
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok, 2 ** 64 - 1}
  end
end
