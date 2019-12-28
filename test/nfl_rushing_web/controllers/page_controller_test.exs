defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase

  describe "GET /" do
    test "shows the page title", %{conn: conn} do
      conn = get(conn, "/")

      assert html_response(conn, 200) =~ "NFL players' rushing statistics"
      assert html_response(conn, 200) =~ "Current temperature: 31"
    end

    test "shows the players' stats table", %{conn: conn} do
      conn = get(conn, "/")
      resp = html_response(conn, 200)

      assert resp =~ "<td>Joe Banyard</td>"
    end

    test "changes temperature to 40", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render_click(view, :change_temperature) =~ "Current temperature: 40"
    end
  end
end
