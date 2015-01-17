defmodule Isis.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

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
    delete "/logout", SessionController, :destroy, as: :login
    
    resources "users", UserController, as: :user, only: [:new, :create]
    resources "projects", ProjectController, as: :project, only: [:new, :create]
  end
  
  channel "robots", Isis.RobotChannel

  # Other scopes may use custom stacks.
  # scope "/api", Isis do
  #   pipe_through :api
  # end
end
