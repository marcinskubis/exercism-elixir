defmodule Username do

  def sanitize([]), do: []
  def sanitize([h | t]) do
    case h do
      ?ä -> [?a, ?e | sanitize(t)]
      ?ö -> [?o, ?e | sanitize(t)]
      ?ü -> [?u, ?e | sanitize(t)]
      ?ß -> [?s, ?s | sanitize(t)]
      h when h >= ?a and h <= ?z -> [h | sanitize(t)]
      ?_ -> [?_ | sanitize(t)]
      _ -> sanitize(t)
    end
  end
end
