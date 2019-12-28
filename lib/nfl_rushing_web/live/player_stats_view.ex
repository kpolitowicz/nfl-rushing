defmodule NflRushingWeb.PlayerStatsView do
  @moduledoc """
  Handles players stats table and all associated events (filtering, sorting).
  """

  use Phoenix.LiveView

  alias NflRushing.PlayerStats

  def render(assigns) do
    Phoenix.View.render(NflRushingWeb.PageView, "index.html", assigns)
  end

  def mount(%{}, socket) do
    stats = PlayerStats.all()
    players = PlayerStats.player_names()

    {:ok, assign(socket, player_stats: stats, names: players)}
  end

  # FIXME: pass current filter to set selected in the filter select
  def handle_event("filter_player", %{"player" => params}, socket) do
    stats = PlayerStats.filter_by(params)
    players = PlayerStats.player_names()

    {:noreply, assign(socket, player_stats: stats, names: players)}
  end
end
