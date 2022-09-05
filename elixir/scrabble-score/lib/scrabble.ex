defmodule Scrabble do
  @letter_values %{
    ~w(A E I O U L N R S T) => 1,
    ~w(D G) => 2,
    ~w(B C M P) => 3,
    ~w(F H V W Y) => 4,
    ~w(K) => 5,
    ~w(J X) => 8,
    ~w(Q Z) => 10
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.codepoints()
    |> Enum.map(&get_score/1)
    |> Enum.sum()
  end

  defp get_score(letter) do
    @letter_values
    |> Enum.find(fn {k, _v} -> Enum.member?(k, letter) end)
    |> case do
      nil -> 0
      {_key, value} -> value
    end
  end
end
