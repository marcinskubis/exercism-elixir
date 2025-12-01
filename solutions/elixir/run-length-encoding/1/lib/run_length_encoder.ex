
defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn chunk ->
      case length(chunk) do
        1 -> hd(chunk)
        n -> "#{n}#{hd(chunk)}"
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d*)([A-Za-z\s])/, string)
    |> Enum.map(fn [_, count, char] ->
      times = if count == "", do: 1, else: String.to_integer(count)
      String.duplicate(char, times)
    end)
    |> Enum.join()
  end
end
