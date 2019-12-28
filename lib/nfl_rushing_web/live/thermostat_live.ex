defmodule NflRushingWeb.ThermostatLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    <button phx-click="change_temperature">+</button>
    """
  end

  def mount(%{id: _id}, socket) do
    temperature = 31
    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_event("change_temperature", _value, socket) do
    new_temp = Enum.random(20..40)
    {:noreply, assign(socket, :temperature, new_temp)}
  end
end
