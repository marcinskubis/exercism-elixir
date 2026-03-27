defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors.
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [c1, c2, c3 | _] = colors  # Take only first 3 colors, ignore the rest

    color_map = %{
      black: 0, brown: 1, red: 2, orange: 3, yellow: 4,
      green: 5, blue: 6, violet: 7, grey: 8, white: 9
    }

    base = color_map[c1] * 10 + color_map[c2]
    multiplier = :math.pow(10, color_map[c3]) |> round()
    value = base * multiplier

    cond do
      value >= 1_000_000_000 -> {div(value, 1_000_000_000), :gigaohms}
      value >= 1_000_000 -> {div(value, 1_000_000), :megaohms}
      value >= 1_000 -> {div(value, 1_000), :kiloohms}
      true -> {value, :ohms}
    end
  end
end