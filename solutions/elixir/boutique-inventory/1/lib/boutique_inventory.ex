defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn x -> x.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      updated_name = String.replace(item.name, old_word, new_word)
      %{item | name: updated_name}
    end)
  end

  def increase_quantity(item, n) do
    updated_quantities =
      Enum.into(item.quantity_by_size, %{}, fn {size, qty} ->
        {size, qty + n}
      end)
    %{item | quantity_by_size: updated_quantities}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, qty}, acc -> acc + qty end)
  end
end
