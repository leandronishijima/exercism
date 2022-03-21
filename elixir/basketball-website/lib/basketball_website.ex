defmodule BasketballWebsite do
  def extract_from_path(nil, _path), do: nil
  def extract_from_path(data, []), do: data

  def extract_from_path(data, path) do
    [head | tail] = extract_path(path)

    extract_from_path(data[head], tail)
  end

  def get_in_path(data, path), do: get_in(data, extract_path(path))

  defp extract_path(path) when is_list(path), do: path
  defp extract_path(path), do: String.split(path, ".")
end
