defmodule NflRushingWeb.ExportControllerTest do
  use NflRushingWeb.ConnCase

  describe "GET /export" do
    test "sends CSV with all players' stats", %{conn: conn} do
      conn = get(conn, "/export")
      resp = conn.resp_body

      assert number_of_rows(resp) == 1 + 326
      assert resp =~ "Joe Banyard,JAX,RB,2,2,7,3.5,7,0,7,0,0,0,0,0\r\n"
    end
  end

  defp number_of_rows(text) do
    text
    |> String.split("\r\n", trim: true)
    |> length()
  end
end
