defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    count_bits(color_count, 0)
  end

  defp count_bits(decimal, bits) do
    if 2 ** bits < decimal do
      count_bits(decimal, bits + 1)
    else
      bits
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end
  
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = PaintByNumber.palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) when picture == <<>>, do: nil
  def get_first_pixel(picture, color_count) do
    bit_size = PaintByNumber.palette_bit_size(color_count)
    <<pixel::size(bit_size), _::bitstring>> = picture
    pixel
  end

  def drop_first_pixel(picture, color_count) when picture == <<>>, do: <<>>
  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_::size(bit_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
