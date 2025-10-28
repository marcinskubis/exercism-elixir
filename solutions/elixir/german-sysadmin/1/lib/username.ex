defmodule Username do

  def sanitize([]), do: []
  def sanitize([h | t]) do
    case h do
      228 -> [97, 101 | sanitize(t)]
      246 -> [111, 101 | sanitize(t)]
      252 -> [117, 101 | sanitize(t)]
      223 -> [115, 115 | sanitize(t)]
      h when h >= ?a and h <= ?z -> [h | sanitize(t)]
      ?_ -> [?_ | sanitize(t)]
      _ -> sanitize(t)
    end
  end
end
