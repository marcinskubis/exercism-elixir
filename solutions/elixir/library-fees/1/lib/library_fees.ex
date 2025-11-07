defmodule LibraryFees do
  def datetime_from_string(string) do
    elem(NaiveDateTime.from_iso8601(string), 1)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)
    if checkout_datetime.hour < 12 do
      Date.shift(date, day: 28)
    else
      Date.shift(date, day: 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    if diff <= 0 do
      0
    else
      diff
    end
      
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
    
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)

    planned_return_date = return_date(checkout_datetime)
    late_days = days_late(planned_return_date, return_datetime)

    fee = late_days * rate

    
    if monday?(return_datetime) do
      div(fee, 2)
    else
      fee
    end

  end
end
