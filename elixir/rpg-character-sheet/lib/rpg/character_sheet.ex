defmodule RPG.CharacterSheet do
  def welcome, do: IO.puts("Welcome! Let's fill out your character sheet together.")

  def ask_name() do
    IO.gets("What is your character's name?\n")
    |> String.trim()
  end

  def ask_class() do
    IO.gets("What is your character's class?\n")
    |> String.trim()
  end

  def ask_level() do
    IO.gets("What is your character's level?\n")
    |> String.trim()
    |> String.to_integer()
  end

  def run() do
    welcome()

    character_name = ask_name()
    character_class = ask_class()
    character_level = ask_level()

    %{
      name: character_name,
      class: character_class,
      level: character_level
    }
    |> IO.inspect(label: "Your character")
  end
end
