
defmodule BasketballWebsite do
  @doc """
  Extracts a value from a nested map using Access behaviour.
  The path is a dot-delimited string of keys.
  Returns `nil` if any key is missing.
  """
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    get_in(data, Enum.map(keys, &Access.key(&1)))
  end

  @doc """
  Uses Kernel's `get_in/2` directly with a dot-delimited path.
  """
  def get_in_path(data, path) do
    keys = String.split(path, ".")
    get_in(data, keys)
  end
end
