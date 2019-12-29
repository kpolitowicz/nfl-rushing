defmodule NflRushingWeb.ExportController do
  use NflRushingWeb, :controller

  alias NflRushing.PlayerStats

  def index(conn, params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"rushing.csv\"")
    |> send_resp(200, csv_content(params))
  end

  defp csv_content(%{"order" => order, "filter" => filter}) do
    PlayerStats.order_by(order, filter)
    |> PlayerStats.to_csv()
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string
  end
end
