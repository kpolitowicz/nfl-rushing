defmodule NflRushingWeb.ExportControllerTest do
  use NflRushingWeb.ConnCase

  describe "GET /export" do
    test "sends CSV with all players' stats", %{conn: conn} do
      conn = get(conn, "/export", %{"order" => "", "filter" => ""})
      resp = conn.resp_body

      assert number_of_rows(resp) == 1 + 326
      assert resp =~ "Joe Banyard,JAX,RB,2,2,7,3.5,7,0,7,0,0,0,0,0\r\n"
    end

    test "sends CSV with sorted data", %{conn: conn} do
      conn = get(conn, "/export", %{"order" => "TD", "filter" => ""})
      resp = conn.resp_body

      assert row(resp, 1) =~
               "LeGarrette Blount,NE,RB,299,18.7,\"1,161\",3.9,72.6,18,44,67,22.4,7,3,2"
    end

    test "sends CSV with filtered data", %{conn: conn} do
      conn = get(conn, "/export", %{"order" => "", "filter" => "Charlie Whitehurst"})
      resp = conn.resp_body

      assert number_of_rows(resp) == 1 + 1
      assert row(resp, 1) =~ "Charlie Whitehurst,CLE,QB,2,2,1,0.5,1,0,2,0,0,0,0,0"
    end
  end

  defp number_of_rows(text) do
    text
    |> split_lines()
    |> length()
  end

  defp row(csv, num) do
    csv
    |> split_lines()
    |> List.to_tuple()
    |> elem(num)
  end

  defp split_lines(csv), do: String.split(csv, "\r\n", trim: true)
end
