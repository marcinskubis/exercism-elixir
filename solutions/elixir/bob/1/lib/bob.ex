defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed = String.trim(input)

    cond do
      trimmed == "" ->
        "Fine. Be that way!"

      question?(trimmed) and yelling?(trimmed) ->
        "Calm down, I know what I'm doing!"

      yelling?(trimmed) ->
        "Whoa, chill out!"

      question?(trimmed) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp question?(text), do: String.ends_with?(text, "?")
  defp yelling?(text) do
    String.match?(text, ~r/\p{Lu}/u) and text == String.upcase(text)
  end
end