
defmodule TwelveDays do
  @ordinals [
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  ]

  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @doc """
  Return the verse for the given day.
  """
  @spec verse(integer) :: String.t()
  def verse(day) when day in 1..12 do
    intro = "On the #{Enum.at(@ordinals, day - 1)} day of Christmas my true love gave to me: "

    gifts =
      case day do
        1 ->
          Enum.at(@gifts, 0) <> "."

        _ ->
          day_gifts =
            @gifts
            |> Enum.slice(0, day)
            |> Enum.reverse()

          Enum.join(day_gifts |> List.replace_at(-1, "and " <> List.last(day_gifts)), ", ") <> "."
      end

    intro <> gifts
  end

  @doc """
  Return verses from starting_verse to ending_verse.
  """
  @spec verses(integer, integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Return all 12 verses.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
