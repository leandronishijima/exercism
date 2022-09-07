defmodule ResistorColorTrio do
  @encoded_colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    colors
    |> Enum.map(&@encoded_colors[&1])
    |> label_colors()
  end

  defp label_colors([first, second, third]) when third >= 4,
    do: make_label([first, second, 0], :kiloohms)

  defp label_colors([first, second, 0]),
    do: make_label([first, second], :ohms)

  defp label_colors([first, second, 1]),
    do: make_label([first, second, 0], :ohms)

  defp label_colors([first, 0, _third]),
    do: make_label([first], :kiloohms)

  defp label_colors([first, second, third]) when third >= 2,
    do: make_label([first, second], :kiloohms)

  defp label_colors([first, second, third]) when third < 2,
    do: make_label([first, second], :ohms)

  defp make_label(digits, resistance_value),
    do: {Integer.undigits(digits), resistance_value}
end
