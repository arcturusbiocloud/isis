use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :isis, Isis.Endpoint,
  url: [host: System.get_env("HOST")],
  http: [port: System.get_env("PORT")],
  secret_key_base: "GUcEIFLP0X/D4BvgBhzF/7KAzA8dwYXC4/mF/EpaIEvXEAchj9Shg6BSrMeonEom"

config :logger,
  level: :info
  
config :phoenix, :database,
  url: System.get_env("DATABASE_URL")
  # url: "ecto://arcturus:ePYQtVfznww9GhMz6Sg9UQ==@arcturus.cinyniivduui.us-west-1.rds.amazonaws.com/isis"
