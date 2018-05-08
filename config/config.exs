# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scrum_app,
  ecto_repos: [ScrumApp.Repo]

# Configures the endpoint
config :scrum_app, ScrumAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QjAIlYKGZ5B55S7JLjMuUsmTTj7ONUL3xnPgggRYDebJHYxh3q1/ghd4UTqJojOm",
  render_errors: [view: ScrumAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ScrumApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
