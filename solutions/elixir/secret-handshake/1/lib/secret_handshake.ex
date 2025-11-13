defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  import Bitwise
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actions = []

    actions =
      if (code &&& 0b00001) != 0, do: actions ++ ["wink"], else: actions
    actions =
      if (code &&& 0b00010) != 0, do: actions ++ ["double blink"], else: actions
    actions =
      if (code &&& 0b00100) != 0, do: actions ++ ["close your eyes"], else: actions
    actions =
      if (code &&& 0b01000) != 0, do: actions ++ ["jump"], else: actions

    if (code &&& 0b10000) != 0, do: Enum.reverse(actions), else: actions
  end
end
