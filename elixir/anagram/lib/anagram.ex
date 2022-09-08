defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates),
    do: Enum.filter(candidates, &anagram?(base, &1))

  defp anagram?(base, candidate) do
    if String.downcase(base) == String.downcase(candidate),
      do: false,
      else: padronize_word(base) == padronize_word(candidate)
  end

  defp padronize_word(word),
    do: word |> String.downcase() |> String.codepoints() |> Enum.sort()
end
