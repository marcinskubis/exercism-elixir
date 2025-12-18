defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    with true <- String.starts_with?(question, "What is "),
         true <- String.ends_with?(question, "?") do
      inner =
        question
        |> String.trim_trailing("?")
        |> String.replace_prefix("What is ", "")
        |> String.trim()
        |> normalize_spaces()

      valid? =
        Regex.match?(
          ~r/^(-?\d+)( (plus|minus|multiplied by|divided by) -?\d+)*$/,
          inner
        )

      if not valid?, do: raise ArgumentError

      tokens =
        Regex.scan(~r/(-?\d+|plus|minus|multiplied by|divided by)/, inner)
        |> Enum.map(fn [tok | _] -> to_token(tok) end)

      evaluate_tokens(tokens)
    else
      _ -> raise ArgumentError
    end
  end
  
  defp normalize_spaces(str) do
    str
    |> String.replace(~r/\s+/, " ")
    |> String.trim()
  end

  defp to_token("plus"), do: :plus
  defp to_token("minus"), do: :minus
  defp to_token("multiplied by"), do: :mul
  defp to_token("divided by"), do: :div
  defp to_token(tok) do
    case Integer.parse(tok) do
      {n, ""} -> n
      _ -> raise ArgumentError
    end
  end

  defp evaluate_tokens([first | rest]) when is_integer(first) do
    do_eval(rest, first)
  end

  defp evaluate_tokens(_), do: raise ArgumentError

  defp do_eval([], acc), do: acc

  defp do_eval([op, num | tail], acc) when is_integer(num) do
    acc2 = apply_op(acc, op, num)
    do_eval(tail, acc2)
  end

  defp do_eval(_, _), do: raise ArgumentError

  defp apply_op(a, :plus, b), do: a + b
  defp apply_op(a, :minus, b), do: a - b
  defp apply_op(a, :mul, b), do: a * b
  defp apply_op(a, :div, b), do: div(a, b)
  defp apply_op(_a, _op, _b), do: raise ArgumentError
end
