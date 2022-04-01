defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      _ in RuntimeError -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      error in ArgumentError -> {:error, error.message}
    end
  end
end
