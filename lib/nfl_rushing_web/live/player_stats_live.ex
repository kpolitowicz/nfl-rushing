defmodule NflRushingWeb.PlayerStatsLive do
  use Phoenix.LiveView

  alias NflRushing.PlayerStats

  def render(assigns) do
    Phoenix.View.render(NflRushingWeb.PageView, "index.html", assigns)
  end

  def mount(%{}, socket) do
    temperature = 31
    stats = PlayerStats.all()

    {:ok, assign(socket, temperature: temperature, player_stats: stats)}
  end

  def handle_event("change_temperature", _value, socket) do
    new_temp = 40
    {:noreply, assign(socket, temperature: new_temp, player_stats: [])}
  end
end
