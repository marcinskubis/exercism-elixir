defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A ->
        1
      ?C ->
        2
      ?G ->
        4
      ?T ->
        8
      _ -> 0
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      1 ->
        65
      2 ->
        67
      4 ->
        71
      8 ->
        84
      0 ->
        32
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc
  defp do_encode([head | tail], acc) do
    encoded = encode_nucleotide(head)
    do_encode(tail, <<acc::bitstring, encoded::size(4)>>)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_decode(<<>>, acc), do: Enum.reverse(acc)
  defp do_decode(<<head::size(4), tail::bitstring>>, acc) do
    decoded = decode_nucleotide(head)
    do_decode(tail, [decoded | acc])
  end
end
