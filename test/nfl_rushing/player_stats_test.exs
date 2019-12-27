defmodule CarpoolService.Core.CarpoolTest do
  use ExUnit.Case

  alias NflRushing.{Player, PlayerStats}

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
end