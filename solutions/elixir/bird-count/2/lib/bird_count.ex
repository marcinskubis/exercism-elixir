defmodule BirdCount do

  def today([]), do: nil
  def today([h | t]), do: h

  def increment_day_count([] = _list), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]

  def has_day_without_birds?([] = _list), do: false
  def has_day_without_birds?([0 | _rest] = _list), do: true
  def has_day_without_birds?([_ | t]), do: has_day_without_birds?(t)

  def total([] = _list), do: 0
  def total([h | t]), do: h + total(t)

  def busy_days([]), do: 0
  def busy_days([h | t]) when h >= 5, do: 1 + busy_days(t)
  def busy_days([_ | t]), do: busy_days(t)
  
end
