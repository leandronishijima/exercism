defmodule FreelancerRates do
  @billable_days 22.0

  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    discount = before_discount * (discount / 100.0)
    before_discount - discount
  end

  def monthly_rate(hourly_rate, discount) do
    (daily_rate(hourly_rate) * @billable_days)
    |> apply_discount(discount)
    |> Float.ceil()
    |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate_after_discount =
      daily_rate(hourly_rate)
      |> apply_discount(discount)

    days_in_budget = budget / daily_rate_after_discount
    Float.floor(days_in_budget, 1)
  end
end
