defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      starts_with_vowel?(word) or String.starts_with?(word, ["xr", "yt"]) ->
        word <> "ay"

      starts_with_qu?(word) ->
        move_qu(word) <> "ay"

      starts_with_consonant_y?(word) ->
        move_until_y(word) <> "ay"

      true ->
        move_consonants(word) <> "ay"
    end
  end

  defp starts_with_vowel?(word), do: String.starts_with?(word, ~w(a e i o u))

  defp starts_with_qu?(word), do: Regex.match?(~r/^[^aeiou]*qu/, word)

  defp starts_with_consonant_y?(word), do: Regex.match?(~r/^[^aeiou]+y/, word)

  defp move_qu(word) do
    Regex.replace(~r/^([^aeiou]*qu)(.*)/, word, "\\2\\1")
  end

  defp move_until_y(word) do
    Regex.replace(~r/^([^aeiou]+)(y.*)/, word, "\\2\\1")
  end

  defp move_consonants(word) do
    Regex.replace(~r/^([^aeiou]+)(.*)/, word, "\\2\\1")
  end
end