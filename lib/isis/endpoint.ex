defmodule Isis.Endpoint do
  use Phoenix.Endpoint, otp_app: :isis

  plug Plug.Static,
    at: "/", from: :isis

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_isis_key",
    signing_salt: "oDh7VASh",
    encryption_salt: "ZPr6VL24"

  plug :router, Isis.Router
end
