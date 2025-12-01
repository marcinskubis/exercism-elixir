defmodule Atbash do
  @alphabet Enum.to_list(?a..?z)
  @reversed Enum.reverse(@alphabet)

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "") # remove punctuation
    |> String.graphemes()
    |> Enum.map(&encode_char/1)
    |> Enum.chunk_every(5)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(~r/\s/, "") # remove spaces
    |> String.graphemes()
    |> Enum.map(&encode_char/1)   # same mapping works for decoding
    |> Enum.join()
  end

  defp encode_char(char) do
    case char do
      <<c>> when c in ?a..?z ->
        index = Enum.find_index(@alphabet, &(&1 == c))
        <<Enum.at(@reversed, index)>>
      _ ->
        char # numbers remain unchanged
    end
  end
end