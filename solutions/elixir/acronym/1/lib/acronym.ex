defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[^a-zA-Z\s-]/, "")  # Remove punctuation except hyphens
    |> String.split(~r/[\s-]+/, trim: true)  # Split by spaces or hyphens
    |> Enum.map(&String.first/1)             # Take first letter of each word
    |> Enum.join()                           # Join letters
    |> String.upcase()                       # Uppercase acronym
  end
end