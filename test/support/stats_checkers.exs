defmodule StatsCheckers do
  defmacro __using__(_options) do
    quote do
      import StatsCheckers, only: :functions
    end
  end

  def players_count(html) do
    html
    |> Floki.find("table tbody tr")
    |> length
  end

  def first_player_name(html) do
    html
    |> Floki.find("table tbody tr td")
    |> hd
    |> Floki.text()
  end

  def player_filter_list(html) do
    html
    |> Floki.find("#player_name option")
  end

  def player_filter_selected(html) do
    html
    |> Floki.find("#player_name option[selected]")
    |> Floki.text()
  end
end
