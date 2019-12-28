defmodule NflRushingWeb.PlayerStatsViewTest do
  use NflRushingWeb.ConnCase, async: true
  use StatsCheckers

  test "filters by player's name", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    resp = render_change(view, :filter_player, %{"player" => %{"name" => "Breshad Perriman"}})

    assert players_count(resp) == 1
    assert first_player_name(resp) == "Breshad Perriman"
  end
end
