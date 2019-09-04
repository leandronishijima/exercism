defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      shouting_and_asking?(input) -> "Calm down, I know what I'm doing!"
      asking?(input) -> "Sure."
      shout?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input), do: "" == String.trim(input)

  defp asking?(input), do: String.ends_with?(input, "?")

  defp shout?(input),
    do:
      input == String.upcase(input) &&
        String.upcase(input) != String.downcase(input)

  defp shouting_and_asking?(input), do: shout?(input) && asking?(input)
end
