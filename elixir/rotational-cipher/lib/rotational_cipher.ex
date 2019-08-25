defmodule RotationalCipher do
  @alphabet_lower ?a..?z
  @alphabet_upper ?A..?Z

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&shift(&1, shift))
    |> to_string()
  end

  defp shift(char, shift) when char in @alphabet_lower do
    rem(char - ?a + shift, 26) + ?a
  end

  defp shift(char, shift) when char in @alphabet_upper do
    rem(char - ?A + shift, 26) + ?A
  end

  defp shift(char, _) do
    char
  end
end
