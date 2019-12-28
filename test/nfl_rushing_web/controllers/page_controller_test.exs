defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase
  use StatsCheckers

  describe "GET /" do
    test "shows the players' stats table", %{conn: conn} do
      conn = get(conn, "/")
      resp = html_response(conn, 200)

      assert resp =~ "NFL players' rushing statistics"
      assert players_count(resp) == 326
      assert first_player_name(resp) == "Joe Banyard"
    end
  end
end
