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

    {:ok, assign(socket, stats: stats)}
  end

  def handle_event("filter_player", %{"player" => params}, socket) do
    stats = PlayerStats.filter_by(params)

    {:noreply, assign(socket, stats: stats)}
  end

  def handle_event("order_by", %{"order" => field}, socket) do
    stats = PlayerStats.order_by(field)

    {:noreply, assign(socket, stats: stats)}
  end
end
