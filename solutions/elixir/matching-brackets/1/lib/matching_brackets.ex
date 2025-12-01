
defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> Enum.reduce([], fn char, stack ->
      cond do
        char in ["[", "{", "("] ->
          [char | stack]

        char in ["]", "}", ")"] ->
          case stack do
            [top | rest] ->
              if matches?(top, char), do: rest, else: [:error]

            _ ->
              [:error]
          end

        true ->
          stack
      end
    end)
    |> case do
      [] -> true
      _ -> false
    end
  end

  defp matches?(open, close) do
    (open == "[" and close == "]") or
      (open == "{" and close == "}") or
      (open == "(" and close == ")")
  end
end
