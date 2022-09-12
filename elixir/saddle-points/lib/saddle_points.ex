defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> Enum.zip_with(& &1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(""), do: []

  def saddle_points(str) do
    row_max = str |> rows() |> Enum.map(&Enum.max/1) |> Enum.with_index(1)
    col_min = str |> columns() |> Enum.map(&Enum.min/1) |> Enum.with_index(1)

    dbg()

    for {row, row_index} <- row_max,
        {col, col_index} <- col_min,
        row == col,
        do: {row_index, col_index}
  end
end
