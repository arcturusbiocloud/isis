# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :isis, Isis.Endpoint,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "GUcEIFLP0X/D4BvgBhzF/7KAzA8dwYXC4/mF/EpaIEvXEAchj9Shg6BSrMeonEom",
  debug_errors: false
  
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
  
config :phoenix, :database,
  url: "ecto://luisbebop@localhost/isis_none"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
