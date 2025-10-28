defmodule BirdCount do
  def today(list) do
    List.first(list)
  end

  def increment_day_count([] = _list) do
    [1]
  end

  def increment_day_count(list) do
    today_count = today(list) + 1
    List.replace_at(list, 0 , today_count)
  end

  def has_day_without_birds?([] = _list), do: false
  def has_day_without_birds?([0 | _rest] = _list), do: true
  def has_day_without_birds?(list) do
    has_day_without_birds?(List.delete_at(list, 0))
  end

  def total([] = _list), do: 0
  def total(list) do
    count = List.first(list)
    count + total(List.delete_at(list, 0))
  end

  def busy_days([]), do: 0
  def busy_days([h | t]) when h >= 5, do: 1 + busy_days(t)
  def busy_days([_ | t]), do: busy_days(t)
  
end
