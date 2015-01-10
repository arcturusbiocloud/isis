use Mix.Config

config :isis, Isis.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :phoenix, :database,
  url: "ecto://luisbebop@localhost/isis_dev"
