defmodule NflRushing.PlayerStats do
  @moduledoc """
  Module to read the player stats from JSON file
  """

  alias NflRushing.Player

  @doc """
  Returns a list of all players as read from the JSON file.
  """
  def all do
    {:ok, stats_str} = File.read(__DIR__ <> "/../../rushing.json")

    stats_str
    |> Jason.decode!()
    |> Enum.map(fn attrs -> to_player(attrs) end)
  end

  @doc """
  Returns list of players filtered by player's name.
  (Essentially a list of 1)
  """
  def filter_by(fields) do
    # FIXME: add teh case for filter by nil (all)
    # FIXME: add unit tests
    all()
    |> Enum.filter(fn player ->
      player.name == fields["name"]
    end)
  end

  defp to_player(attrs) do
    %Player{
      name: attrs["Player"],
      team: attrs["Team"],
      position: attrs["Pos"],
      rushing_attempts: attrs["Att"],
      rushing_attempts_per_game: attrs["Att/G"],
      total_rushing_yards: attrs["Yds"],
      avg_rushing_yards_per_attempt: attrs["Avg"],
      rushing_yards_per_game: attrs["Yds/G"],
      total_rushing_touchdowns: attrs["TD"],
      longest_rush: attrs["Lng"],
      rushing_first_downs: attrs["1st"],
      rushing_first_down_percentage: attrs["1st%"],
      rushing_20_plus_yards: attrs["20+"],
      rushing_40_plus_yards: attrs["40+"],
      rushing_fumbles: attrs["FUM"]
    }
  end
end
