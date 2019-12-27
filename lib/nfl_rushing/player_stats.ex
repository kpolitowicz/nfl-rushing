defmodule NflRushing.PlayerStats do
  @moduledoc """
  Module to read the player stats from JSON file
  """

  alias NflRushing.Player

  def all do
    [
      %Player{name: "Joe Banyard"}
    ]
  end
end
