defmodule NflRushing.PlayerStats do
  @moduledoc """
  Module to read the player stats from JSON file
  """

  alias NflRushing.Player

  defstruct ~w[stats players filtered_by_name ordered_by]a

  @doc """
  Returns a list of all players as read from the JSON file.
  """
  def all do
    stats = read_stats_from_file()

    %__MODULE__{
      stats: stats,
      players: player_names(stats),
      filtered_by_name: "",
      ordered_by: ""
    }
  end

  @doc """
  Returns list of players filtered by player's name.
  (Essentially a list of 1)
  Returns the whole list if "" is passed.
  """
  def filter_by(%{"name" => name}) do
    stats = read_stats_from_file()

    %__MODULE__{
      stats: filter_by_name(stats, name),
      players: player_names(stats),
      filtered_by_name: name,
      ordered_by: ""
    }
  end

  @doc """
  Returns list of players ordered by given attribute.
  The allowed attributes are: TD, Yds and Lng.
  """
  def order_by(attr, filter_by_name) do
    stats = read_stats_from_file()

    %__MODULE__{
      stats: stats |> filter_by_name(filter_by_name) |> order_by_attr(attr),
      players: player_names(stats),
      filtered_by_name: filter_by_name,
      ordered_by: attr
    }
  end

  @doc """
  Returns player stats as list of lists to easy convert to CSV
  """
  def to_csv(stats) do
    data =
      stats.stats
      |> Enum.map(
        &[
          &1.name,
          &1.team,
          &1.position,
          &1.rushing_attempts,
          &1.rushing_attempts_per_game,
          &1.total_rushing_yards,
          &1.avg_rushing_yards_per_attempt,
          &1.rushing_yards_per_game,
          &1.total_rushing_touchdowns,
          &1.longest_rush,
          &1.rushing_first_downs,
          &1.rushing_first_down_percentage,
          &1.rushing_20_plus_yards,
          &1.rushing_40_plus_yards,
          &1.rushing_fumbles
        ]
      )

    [headers() | data]
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
    |> Enum.sort()
  end

  defp filter_by_name(stats, ""), do: stats

  defp filter_by_name(stats, name) do
    stats
    |> Enum.filter(fn player ->
      player.name == name
    end)
  end

  defp order_by_attr(stats, "TD") do
    stats
    |> Enum.sort(&(&1.total_rushing_touchdowns > &2.total_rushing_touchdowns))
  end

  defp order_by_attr(stats, "Lng") do
    stats
    |> Enum.sort(&(&1.longest_rush_int > &2.longest_rush_int))
  end

  defp order_by_attr(stats, "Yds") do
    stats
    |> Enum.sort(&(&1.total_rushing_yards_int > &2.total_rushing_yards_int))
  end

  defp order_by_attr(stats, _), do: stats

  defp to_player(attrs) do
    %Player{
      name: attrs["Player"],
      team: attrs["Team"],
      position: attrs["Pos"],
      rushing_attempts: attrs["Att"],
      rushing_attempts_per_game: attrs["Att/G"],
      total_rushing_yards: attrs["Yds"],
      total_rushing_yards_int: yds_to_int(attrs["Yds"]),
      avg_rushing_yards_per_attempt: attrs["Avg"],
      rushing_yards_per_game: attrs["Yds/G"],
      total_rushing_touchdowns: attrs["TD"],
      longest_rush: attrs["Lng"],
      longest_rush_int: lng_to_int(attrs["Lng"]),
      rushing_first_downs: attrs["1st"],
      rushing_first_down_percentage: attrs["1st%"],
      rushing_20_plus_yards: attrs["20+"],
      rushing_40_plus_yards: attrs["40+"],
      rushing_fumbles: attrs["FUM"]
    }
  end

  defp lng_to_int(lng) when is_integer(lng), do: lng

  defp lng_to_int(lng) do
    lng
    |> Integer.parse()
    |> elem(0)
  end

  defp yds_to_int(yds) when is_integer(yds), do: yds

  defp yds_to_int(yds) when is_binary(yds) do
    yds
    |> String.replace(",", "")
    |> Integer.parse()
    |> elem(0)
  end

  defp headers do
    [
      "Player",
      "Team",
      "Pos",
      "Att",
      "Att/G",
      "Yds",
      "Avg",
      "Yds/G",
      "TD",
      "Lng",
      "1st",
      "1st%",
      "20+",
      "40+",
      "FUM"
    ]
  end
end
