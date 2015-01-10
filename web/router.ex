defmodule Isis.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Isis do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", Isis do
  #   pipe_through :api
  # end
end
