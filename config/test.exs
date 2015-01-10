use Mix.Config

config :isis, Isis.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
  
config :phoenix, :database,
  url: "ecto://luisbebop@localhost/isis_test?size=1&max_overflow=0"
