defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  alias NflRushing.PlayerStats

  def index(conn, _params) do
    stats = PlayerStats.all

    render(conn, "index.html", player_stats: stats)
  end
end
