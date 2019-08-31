defmodule RomanNumerals do
  @roman %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  @roman_keys Map.keys(@roman) |> Enum.sort(&(&1 > &2))

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    to_roman(@roman_keys, number, "")
  end

  defp to_roman(_, 0, result), do: result

  defp to_roman([head | tail] = keys, number, result) do
    cond do
      number >= head ->
        to_roman(keys, number - head, result <> @roman[head])

      true ->
        to_roman(tail, number, result)
    end
  end
end
