defmodule LibraryFees do
  @day_in_seconds 24 * 60 * 60

  def datetime_from_string(string) do
    {:ok, result} = NaiveDateTime.from_iso8601(string)

    result
  end

  def before_noon?(datetime),
    do: Time.compare(~T[12:00:00], NaiveDateTime.to_time(datetime)) == :gt

  def return_date(checkout_datetime) do
    calculated_date =
      if before_noon?(checkout_datetime),
        do: NaiveDateTime.add(checkout_datetime, @day_in_seconds * 28, :second),
        else: NaiveDateTime.add(checkout_datetime, @day_in_seconds * 29, :second)

    NaiveDateTime.to_date(calculated_date)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return = NaiveDateTime.to_date(actual_return_datetime)

    case Date.diff(planned_return_date, actual_return) do
      diff when diff > 0 -> 0
      diff -> diff * -1
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)

    days_late =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_datetime)

    fee = rate * days_late
    if monday?(return_datetime), do: div(fee, 2), else: fee
  end
end
