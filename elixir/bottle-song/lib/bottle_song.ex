defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    build_lyrics("", start_bottle, take_down)
  end

  defp build_lyrics(lyric, _, 0), do: lyric

  defp build_lyrics(lyric, start_bottle, take_down) do
    bottles_to_s = number_to_string(start_bottle)
    missing_bottles = start_bottle - 1

    lyric =
      if lyric == "" do
        lyric
      else
        lyric <> "\n\n"
      end

    lyric =
      lyric <>
        """
        #{first_verse(bottles_to_s)}
        #{first_verse(bottles_to_s)}
        And if one green bottle should accidentally fall,
        #{last_verse(missing_bottles)}\
        """

    build_lyrics(lyric, missing_bottles, take_down - 1)
  end

  defp first_verse("One"), do: "One green bottle hanging on the wall,"
  defp first_verse(bottles_to_s), do: "#{bottles_to_s} green bottles hanging on the wall,"

  defp last_verse(0), do: "There'll be no green bottles hanging on the wall."

  defp last_verse(missing_bottles) do
    missing_bottles_to_s =
      missing_bottles
      |> number_to_string()
      |> String.downcase()

    "There'll be #{missing_bottles_to_s} green #{bottles(missing_bottles)} hanging on the wall."
  end

  defp bottles(number_of_bottles) when number_of_bottles > 1, do: "bottles"
  defp bottles(_), do: "bottle"

  defp number_to_string(bottles_number) do
    case bottles_number do
      10 -> "Ten"
      9 -> "Nine"
      8 -> "Eight"
      7 -> "Seven"
      6 -> "Six"
      5 -> "Five"
      4 -> "Four"
      3 -> "Three"
      2 -> "Two"
      1 -> "One"
    end
  end
end
