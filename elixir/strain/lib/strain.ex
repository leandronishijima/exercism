defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    strain(list, fun)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    strain(list, &(not fun.(&1)))
  end

  defp strain(_ = [], _), do: []

  defp strain([head | tail], fun) do
    if fun.(head) do
      [head | strain(tail, fun)]
    else
      strain(tail, fun)
    end
  end
end
