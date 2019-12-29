defmodule NflRushingWeb.PlayerStatsViewTest do
  use NflRushingWeb.ConnCase, async: true
  use StatsCheckers

  test "filters by player's name", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    resp = render_change(view, :filter_player, %{"player" => %{"name" => "Breshad Perriman"}})

    assert players_count(resp) == 1
    assert first_player_name(resp) == "Breshad Perriman"
    assert player_filter_list(resp) |> length == 326 + 1
    assert player_filter_selected(resp) == "Breshad Perriman"
  end

  test "orders by TD", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    resp = render_change(view, :order_by, %{"order" => "TD"})

    assert first_player_name(resp) == "LeGarrette Blount"
  end

  # FIXME: add test for order with filter?
  # FIXME: add test for filter with order?
end
