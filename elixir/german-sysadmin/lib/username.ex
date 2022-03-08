defmodule Username do
  def sanitize('') do
    ''
  end

  def sanitize([head | tail]) do
    sanitized_char =
      case head do
        ?ß -> 'ss'
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        char when char in ?a..?z -> [char]
        ?_ -> '_'
        _ -> ''
      end

    sanitized_char ++ sanitize(tail)
  end
end
