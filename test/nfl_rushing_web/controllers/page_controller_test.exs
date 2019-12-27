defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase

  describe "GET /" do
    test "shows the page title", %{conn: conn} do
      conn = get(conn, "/")

      assert html_response(conn, 200) =~ "NFL players' rushing statistics"
    end
  end
end
