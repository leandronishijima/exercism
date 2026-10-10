defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.keys()
    |> Enum.reduce(%{}, fn key, acc ->
      points_map =
        Enum.reduce(input[key], %{}, fn letter, inner_acc ->
          Map.put(inner_acc, String.downcase(letter), key)
        end)

      Map.merge(acc, points_map)
    end)
  end
end
