defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %__MODULE__{
      map: Enum.reduce(enumerable, %{}, &Map.put(&2, &1, nil))
    }
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    Map.keys(custom_set.map) == []
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    case Map.fetch(custom_set.map, element) do
      {:ok, _} -> true
      _ -> false
    end
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.all?(&Map.has_key?(custom_set_2.map, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.all?(&(not Map.has_key?(custom_set_2.map, &1)))
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    Map.equal?(custom_set_1.map, custom_set_2.map)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %__MODULE__{
      map: Map.put(custom_set.map, element, nil)
    }
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_2.map
    |> Map.reject(fn {key, _val} ->
      not contains?(custom_set_1, key)
    end)
    |> Map.keys()
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.filter(&(not contains?(custom_set_2, &1)))
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    %__MODULE__{map: Map.merge(custom_set_1.map, custom_set_2.map)}
  end
end
