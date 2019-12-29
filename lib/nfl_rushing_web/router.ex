defmodule NflRushingWeb.Router do
  use NflRushingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :csv do
    plug :accepts, ["csv"]
  end

  scope "/", NflRushingWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", NflRushingWeb do
    pipe_through :csv

    get "/export", ExportController, :index
  end
end
