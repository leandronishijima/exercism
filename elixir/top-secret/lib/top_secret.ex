defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  @def_ops [:def, :defp]
  def decode_secret_message_part(
        {operation, _, [{:when, _, [{name, _, args} | _]} | _]} = ast,
        acc
      )
      when operation in @def_ops do
    acc = add_part(name, if(is_atom(args), do: 0, else: length(args)), acc)
    {ast, acc}
  end

  def decode_secret_message_part({operation, _, [{name, _, args} | _]} = ast, acc)
      when operation in @def_ops do
    acc = add_part(name, if(is_atom(args), do: 0, else: length(args)), acc)
    {ast, acc}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_, message} =
      string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)

    message
    |> Enum.reverse()
    |> Enum.join()
  end

  defp add_part(name, arity, acc) do
    name
    |> to_string()
    |> String.slice(0, arity)
    |> then(&[&1 | acc])
  end
end
