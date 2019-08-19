defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> List.to_string()
    |> String.graphemes()
    |> Enum.map(fn f -> dna_to_rna(to_string(f)) end)
    |> List.flatten()
  end

  def dna_to_rna(dna) do
    case dna do
      "G" -> 'C'
      "C" -> 'G'
      "T" -> 'A'
      "A" -> 'U'
    end
  end
end
