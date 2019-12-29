defmodule CarpoolService.Core.CarpoolTest do
  use ExUnit.Case

  alias NflRushing.{Player, PlayerStats}

  # FIXME: make separate (shorter list) for tests
  describe "all" do
    test "reads data from JSON file to Player structs" do
      stats = PlayerStats.all()

      assert 326 = length(stats.stats)

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
             } = hd(stats.stats)
    end

    test "returns all player names" do
      stats = PlayerStats.all()

      assert 326 = length(stats.players)
      assert hd(stats.players) == "Aaron Ripkowski"
    end
  end

  describe "filter_by" do
    test "filters player stats by player name" do
      stats = PlayerStats.filter_by(%{"name" => "Charlie Whitehurst"})

      assert 1 = length(stats.stats)
      assert %Player{name: "Charlie Whitehurst", team: "CLE"} = hd(stats.stats)
    end

    test "still returns the full list of player names" do
      stats = PlayerStats.filter_by(%{"name" => "Charlie Whitehurst"})

      assert 326 = length(stats.players)
    end

    test "returns the whole list if nil is passed" do
      stats = PlayerStats.filter_by(%{"name" => ""})

      assert 326 = length(stats.stats)
    end
  end

  describe "order_by" do
    test "sorts descending by TD" do
      stats = PlayerStats.order_by("TD", "")

      assert %Player{name: "LeGarrette Blount", total_rushing_touchdowns: 18} = hd(stats.stats)
    end

    test "sorts descending by Lng (as numbers)" do
      stats = PlayerStats.order_by("Lng", "")

      assert %Player{name: "Isaiah Crowell", longest_rush: "85T"} = hd(stats.stats)
    end

    test "sorts descending by Yds (as numbers)" do
      stats = PlayerStats.order_by("Yds", "")

      assert %Player{name: "Ezekiel Elliott", total_rushing_yards: "1,631"} = hd(stats.stats)
    end

    test "keep filter on" do
      stats = PlayerStats.order_by("TD", "Charlie Whitehurst")

      assert 1 = length(stats.stats)
      assert "Charlie Whitehurst" = stats.filtered_by_name
      assert %Player{name: "Charlie Whitehurst", total_rushing_touchdowns: 0} = hd(stats.stats)
    end
  end
end
