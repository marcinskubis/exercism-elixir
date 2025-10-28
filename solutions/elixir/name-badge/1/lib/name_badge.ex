defmodule NameBadge do
  def print(id, name, department) do
    if department === nil do
      if id === nil do
        "#{name} - OWNER"
      else
        "[#{id}] - #{name} - OWNER"
      end
    else
      dept = String.upcase(department)
      if id === nil do
        "#{name} - #{dept}"
      else
        "[#{id}] - #{name} - #{dept}"
      end
    end
  end
end
