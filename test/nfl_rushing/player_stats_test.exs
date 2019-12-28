defmodule CarpoolService.Core.CarpoolTest do
  use ExUnit.Case

  alias NflRushing.{Player, PlayerStats}

  # FIXME: make separate (shorter list) for tests
  describe "all" do
    test "reads data from JSON file to Player structs" do
      list = PlayerStats.all()

      assert 326 = length(list)

      assert %Player{
               name: "Joe Banyard",
               team: "JAX",
               position: "RB",
               rushing_attempts: 2,
               rushing_attempts_per_game: 2,
               total_rushing_yards: 7,
               avg_rushing_yards_per_attempt: 3.5,
               rushing_yards_per_game: 7,
               total_rushing_touchdowns: 0,
               longest_rush: "7",
               rushing_first_downs: 0,
               rushing_first_down_percentage: 0,
               rushing_20_plus_yards: 0,
               rushing_40_plus_yards: 0,
               rushing_fumbles: 0
             } = hd(list)
    end
  end

  describe "filter_by" do
    test "filters player stats by player name" do
      list = PlayerStats.filter_by(%{"name" => "Charlie Whitehurst"})

      assert 1 = length(list)
      assert %Player{name: "Charlie Whitehurst", team: "CLE"} = hd(list)
    end

    test "returns the whole list if nil is passed" do
      list = PlayerStats.filter_by(%{"name" => ""})

      assert 326 = length(list)
    end
  end
end
