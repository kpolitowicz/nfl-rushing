defmodule NflRushing.PlayerStats do
  @moduledoc """
  Module to read the player stats from JSON file
  """

  alias NflRushing.Player

  defstruct ~w[stats players filtered_by_name]a

  @doc """
  Returns a list of all players as read from the JSON file.
  """
  def all do
    stats = read_stats_from_file()

    %__MODULE__{
      stats: stats,
      players: player_names(stats),
      filtered_by_name: ""
    }
  end

  @doc """
  Returns list of players filtered by player's name.
  (Essentially a list of 1)
  Returns the whole list if "" is passed.
  """
  def filter_by(%{"name" => ""}), do: all()

  def filter_by(%{"name" => name}) do
    stats = read_stats_from_file()

    %__MODULE__{
      stats: filter_by_name(stats, name),
      players: player_names(stats),
      filtered_by_name: name
    }
  end

  defp read_stats_from_file do
    {:ok, stats_str} = File.read(__DIR__ <> "/../../rushing.json")

    stats_str
    |> Jason.decode!()
    |> Enum.map(fn attrs -> to_player(attrs) end)
  end

  defp player_names(full_stats) do
    full_stats
    |> Enum.map(fn p -> p.name end)
    |> Enum.sort
  end

  defp filter_by_name(stats, name) do
    stats
    |> Enum.filter(fn player ->
      player.name == name
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
