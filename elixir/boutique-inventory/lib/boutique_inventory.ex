defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price, :asc)

  def with_missing_price(inventory), do: Enum.filter(inventory, &is_nil(&1.price))

  def increase_quantity(item, count) do
    item
    |> Enum.map(fn {key, value} ->
      if key == :quantity_by_size do
        value =
          value
          |> Enum.map(fn {quantity_key, current_value} ->
            {quantity_key, current_value + count}
          end)
          |> Enum.into(%{})

        {key, value}
      else
        {key, value}
      end
    end)
    |> Enum.into(%{})
  end

  def total_quantity(%{quantity_by_size: quantity}),
    do: Enum.reduce(quantity, 0, fn {_, value}, acc -> value + acc end)
end
