defmodule ResistorColorDuo do
  @colors %{
    black: "0",
    brown: "1",
    red: "2",
    orange: "3",
    yellow: "4",
    green: "5",
    blue: "6",
    violet: "7",
    grey: "8",
    white: "9"
  }
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first, second | _]) do
    Integer.parse(Map.get(@colors, first, "0") <> Map.get(@colors, second, "0")) |> elem(0)
  end
end
