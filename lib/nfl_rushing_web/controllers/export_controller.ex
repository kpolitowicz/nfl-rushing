defmodule NflRushingWeb.ExportController do
  use NflRushingWeb, :controller

  alias NflRushing.PlayerStats

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"rushing.csv\"")
    |> send_resp(200, csv_content())
  end

  defp csv_content do
    PlayerStats.all()
    |> PlayerStats.to_csv()
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end
end
