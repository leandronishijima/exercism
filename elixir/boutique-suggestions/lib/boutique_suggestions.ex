defmodule BoutiqueSuggestions do
  @default_maximum_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    for x <- tops,
        y <- bottoms,
        filter_combinations(x, y, options) do
      {x, y}
    end
  end

  defp filter_combinations(x, y, options),
    do: filter_out_clashing_outfits(x, y) and filter_by_combination_price(x, y, options)

  defp filter_out_clashing_outfits(%{base_color: first_color}, %{base_color: second_color}),
    do: first_color != second_color

  defp filter_by_combination_price(x, y, options),
    do: comparing_prices(x, y, get_in(options, [:maximum_price]))

  defp comparing_prices(x, y, nil), do: x.price + y.price <= @default_maximum_price
  defp comparing_prices(x, y, maximum_price), do: x.price + y.price <= maximum_price
end
