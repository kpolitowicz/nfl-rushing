defmodule NflRushingWeb.PageView do
  use NflRushingWeb, :view

  # FIXME: this is only necessary because LiveView template cannot access @conn to generate route
  def export_path(stats) do
    "/export?#{URI.encode_query(filter: stats.filtered_by_name, order: stats.ordered_by)}"
  end
end
