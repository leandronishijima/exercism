defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(1), do: {:ok, :deficient}
  def classify(0), do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) when number < 0,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    classify(aliquot_sum(number), number)
  end

  defp classify(aliquot_sum, number) when aliquot_sum == number, do: {:ok, :perfect}
  defp classify(aliquot_sum, number) when aliquot_sum > number, do: {:ok, :abundant}
  defp classify(aliquot_sum, number) when aliquot_sum < number, do: {:ok, :deficient}

  defp aliquot_sum(number) do
    1..(number - 1)
    |> Enum.filter(fn n -> rem(number, n) == 0 end)
    |> Enum.sum()
  end
end
