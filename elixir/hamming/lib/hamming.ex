defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2),
    do: {:error, "strands must be of equal length"}

  def hamming_distance(strand1, strand2) do
    {:ok,
     strand1
     |> Enum.with_index()
     |> Enum.reduce(0, fn {letter, index}, acc ->
       if Enum.at(strand2, index) == letter,
         do: acc,
         else: acc + 1
     end)}
  end
end
