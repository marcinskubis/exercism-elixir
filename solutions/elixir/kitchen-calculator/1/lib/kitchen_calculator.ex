defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  # cup -> ml
  def to_milliliter({:cup, _volume} = volume_pair) do
    ml_vol = get_volume(volume_pair) * 240
    {:milliliter, ml_vol}
  end

  # ml -> ml
  def to_milliliter({:milliliter, _volume} = volume_pair) do
    volume_pair
  end

  # fluid ounce -> ml
  def to_milliliter({:fluid_ounce, _volume} = volume_pair) do
    ml_vol = get_volume(volume_pair) * 30
    {:milliliter, ml_vol}
  end

  # teaspoon -> ml
  def to_milliliter({:teaspoon, _volume} = volume_pair) do
    ml_vol = get_volume(volume_pair) * 5
    {:milliliter, ml_vol}
  end

  # tablespoon -> ml
  def to_milliliter({:tablespoon, _volume} = volume_pair) do
    ml_vol = get_volume(volume_pair) * 15
    {:milliliter, ml_vol}
  end

  # ml -> cup
  def from_milliliter(volume_pair, :cup = unit) do
    vol = get_volume(volume_pair) / 240
    {unit, vol}
  end

  # ml -> fluid ounce
  def from_milliliter(volume_pair, :fluid_ounce = unit) do
    vol = get_volume(volume_pair) / 30
    {unit, vol}
  end

  # ml -> teaspoon
  def from_milliliter(volume_pair, :teaspoon = unit) do
    vol = get_volume(volume_pair) / 5
    {unit, vol}
  end

  # ml -> tablespoon
  def from_milliliter(volume_pair, :tablespoon = unit) do
    vol = get_volume(volume_pair) / 15
    {unit, vol}
  end

  # ml -> ml
  def from_milliliter(volume_pair, :milliliter = unit) do
    volume_pair
  end

  def convert(volume_pair, unit) do
    ml_vol = to_milliliter(volume_pair)
    from_milliliter(ml_vol, unit)
  end
end
