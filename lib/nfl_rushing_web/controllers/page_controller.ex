defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  def index(conn, _params) do
    live_render(conn, NflRushingWeb.PlayerStatsLive)
  end
end
