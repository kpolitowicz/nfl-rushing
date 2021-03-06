# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nfl_rushing, NflRushingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xg5TOGf4QAub81+lpiJdfM8ZKsRTveWjmzVWeJHEPvIq1CRevayleZAE+8Qf8ZP6",
  live_view: [
    signing_salt: "5Enf1gq30DBoXcrvSTpc6BkfBZVApozQ"
  ],
  render_errors: [view: NflRushingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NflRushing.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
