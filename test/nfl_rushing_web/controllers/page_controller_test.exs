defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase

  describe "GET /" do
    test "shows the players' stats table", %{conn: conn} do
      conn = get(conn, "/")
      resp = html_response(conn, 200)

      assert resp =~ "NFL players' rushing statistics"
      assert players_count(resp) == 326
      assert first_player_name(resp) == "Joe Banyard"
    end

    test "changes temperature to 40", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render_click(view, :change_temperature) =~ "Current temperature: 40"
    end

    defp players_count(html) do
      html
      |> Floki.find("table tbody tr")
      |> length
    end

    defp first_player_name(html) do
      html
      |> Floki.find("table tbody tr td")
      |> hd
      |> Floki.text
    end
  end
end
