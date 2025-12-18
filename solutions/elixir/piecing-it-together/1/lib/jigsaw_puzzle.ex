
defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(%JigsawPuzzle{} = puzzle) do
    case compute_rc(puzzle) do
      {:error, msg} ->
        {:error, msg}

      :unknown ->
        {:error, "Insufficient data"}

      {:ok, {r, c}} ->
        p = r * c
        ar = c / r
        fmt = format_from_aspect(ar)
        b = border_count(r, c)
        inside = p - b

        with :ok <- assert_equal_int(puzzle.pieces, p),
             :ok <- assert_equal_int(puzzle.rows, r),
             :ok <- assert_equal_int(puzzle.columns, c),
             :ok <- assert_equal_fmt(puzzle.format, fmt),
             :ok <- assert_equal_float(puzzle.aspect_ratio, ar),
             :ok <- assert_equal_int(puzzle.border, b),
             :ok <- assert_equal_int(puzzle.inside, inside) do
          {:ok,
           %JigsawPuzzle{
             pieces: p,
             rows: r,
             columns: c,
             format: fmt,
             aspect_ratio: ar,
             border: b,
             inside: inside
           }}
        else
          {:error, _} -> {:error, "Contradictory data"}
        end
    end
  end

  defp compute_rc(%JigsawPuzzle{rows: r, columns: c})
       when is_integer(r) and is_integer(c) and r > 0 and c > 0,
       do: {:ok, {r, c}}

  defp compute_rc(%JigsawPuzzle{rows: r, aspect_ratio: a})
       when is_integer(r) and r > 0 and is_number(a) do
    with {:ok, c} <- int_from_float(a * r),
         true <- c > 0 do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{columns: c, aspect_ratio: a})
       when is_integer(c) and c > 0 and is_number(a) do
    with {:ok, r} <- int_from_float(c / a),
         true <- r > 0 do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{pieces: p, aspect_ratio: a})
       when is_integer(p) and p > 0 and is_number(a) and a > 0 do
    # p = r*c = r*(a*r) -> r^2 = p/a
    with {:ok, r} <- int_from_float(:math.sqrt(p / a)),
         {:ok, c} <- int_from_float(a * r),
         true <- r > 0 and c > 0 and r * c == p do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{format: :square, rows: r})
       when is_integer(r) and r > 0,
       do: {:ok, {r, r}}

  defp compute_rc(%JigsawPuzzle{format: :square, columns: c})
       when is_integer(c) and c > 0,
       do: {:ok, {c, c}}

  defp compute_rc(%JigsawPuzzle{pieces: p, rows: r})
       when is_integer(p) and p > 0 and is_integer(r) and r > 0 do
    if rem(p, r) == 0, do: {:ok, {r, div(p, r)}}, else: {:error, "Contradictory data"}
  end

  defp compute_rc(%JigsawPuzzle{pieces: p, columns: c})
       when is_integer(p) and p > 0 and is_integer(c) and c > 0 do
    if rem(p, c) == 0, do: {:ok, {div(p, c), c}}, else: {:error, "Contradictory data"}
  end

  defp compute_rc(%JigsawPuzzle{border: b, rows: r})
       when is_integer(b) and b > 0 and is_integer(r) and r > 0 do
    s = (b + 4) / 2
    with {:ok, s_int} <- int_from_float(s),
         c <- s_int - r,
         true <- c > 0 do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{border: b, columns: c})
       when is_integer(b) and b > 0 and is_integer(c) and c > 0 do
    s = (b + 4) / 2
    with {:ok, s_int} <- int_from_float(s),
         r <- s_int - c,
         true <- r > 0 do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{border: b, aspect_ratio: a})
       when is_integer(b) and b > 0 and is_number(a) and a > 0 do
    s = (b + 4) / 2
    with {:ok, r} <- int_from_float(s / (1 + a)),
         {:ok, c} <- int_from_float(a * r),
         true <- r > 0 and c > 0 do
      {:ok, {r, c}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{border: b, pieces: p, format: fmt})
       when is_integer(b) and b > 0 and is_integer(p) and p > 0 do
    s = (b + 4) / 2

    with {:ok, s_int} <- int_from_float(s),
         {:ok, {r, c}} <- solve_rc_sum_prod(s_int, p) do
      case fmt do
        :portrait ->
          if c < r, do: {:ok, {r, c}}, else: {:ok, {c, r}}

        :landscape ->
          if c > r, do: {:ok, {r, c}}, else: {:ok, {c, r}}

        :square ->
          if r == c, do: {:ok, {r, r}}, else: {:error, "Contradictory data"}

        nil ->
          {:ok, {r, c}}
      end
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{inside: i, aspect_ratio: a})
       when is_integer(i) and i >= 0 and is_number(a) do
    if approx_equal(a, 1.0) do
      with {:ok, k} <- int_from_float(:math.sqrt(i)),
           n <- k + 2,
           true <- n > 0 do
        {:ok, {n, n}}
      else
        _ -> {:error, "Contradictory data"}
      end
    else
      :unknown
    end
  end

  defp compute_rc(%JigsawPuzzle{inside: i, format: :square})
       when is_integer(i) and i >= 0 do
    with {:ok, k} <- int_from_float(:math.sqrt(i)),
         n <- k + 2,
         true <- n > 0 do
      {:ok, {n, n}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{inside: i, pieces: p})
       when is_integer(i) and is_integer(p) and p > 0 and i >= 0,
       do: :unknown

  defp compute_rc(%JigsawPuzzle{format: :square, pieces: p})
       when is_integer(p) and p > 0 do
    with {:ok, n} <- int_from_float(:math.sqrt(p)),
         true <- n * n == p do
      {:ok, {n, n}}
    else
      _ -> {:error, "Contradictory data"}
    end
  end

  defp compute_rc(%JigsawPuzzle{}), do: :unknown

  defp solve_rc_sum_prod(s, p) when is_integer(s) and is_integer(p) and s > 1 and p > 0 do
    d = s * s - 4 * p
    if d < 0 do
      {:error, "Contradictory data"}
    else
      with {:ok, k} <- int_from_float(:math.sqrt(d)),
           {:ok, r} <- int_from_float((s + k) / 2),
           {:ok, c} <- int_from_float((s - k) / 2),
           true <- r > 0 and c > 0 and r * c == p and r + c == s do
        {:ok, {r, c}}
      else
        _ -> {:error, "Contradictory data"}
      end
    end
  end

  defp border_count(r, c) when r == 1 and c == 1, do: 1
  defp border_count(r, c) when r == 1, do: c
  defp border_count(r, c) when c == 1, do: r
  defp border_count(r, c), do: 2 * (r + c) - 4

  defp format_from_aspect(a) do
    cond do
      approx_equal(a, 1.0) -> :square
           a < 1.0 -> :portrait
      true -> :landscape
    end
  end

  defp approx_equal(a, b), do: abs(a - b) < 1.0e-12

  defp int_from_float(x) when is_integer(x), do: {:ok, x}
  defp int_from_float(x) when is_number(x) do
    i = round(x)
    if abs(x - i) < 1.0e-9, do: {:ok, i}, else: {:error, :not_int}
  end

  defp assert_equal_int(nil, _), do: :ok
  defp assert_equal_int(given, calc) when is_integer(given) and is_integer(calc),
    do: if(given == calc, do: :ok, else: {:error, :int_mismatch})

  defp assert_equal_float(nil, _), do: :ok
  defp assert_equal_float(given, calc) when is_number(given) and is_number(calc),
    do: if(approx_equal(given, calc), do: :ok, else: {:error, :float_mismatch})

  defp assert_equal_fmt(nil, _), do: :ok
  defp assert_equal_fmt(given, calc), do: if(given == calc, do: :ok, else: {:error, :fmt_mismatch})
end