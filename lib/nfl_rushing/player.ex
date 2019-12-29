defmodule NflRushing.Player do
  @moduledoc """
  Struct to keep player's rushing stats.
  """

  defstruct ~w[
    name
    team
    position
    rushing_attempts_per_game
    rushing_attempts
    total_rushing_yards
    avg_rushing_yards_per_attempt
    rushing_yards_per_game
    total_rushing_touchdowns
    longest_rush
    longest_rush_int
    rushing_first_downs
    rushing_first_down_percentage
    rushing_20_plus_yards
    rushing_40_plus_yards
    rushing_fumbles
  ]a
end
