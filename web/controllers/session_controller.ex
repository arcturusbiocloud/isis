defmodule Isis.SessionController do
  use Isis.Helper.Application
  alias Isis.User
  alias Plug.Conn
  
  plug :action

  def new(conn, _params) do
    render conn, "new.html", %{title: "Log In"}
  end
  
  def create(conn, params) do
    user = User.get(params["email"])
    if User.auth?(user, params["password"]) do
      conn
      |> Conn.fetch_session
      |> Conn.put_session(:email, user.email)
      |> Flash.put(:notice, "Logged in as #{user.email}")
      |> redirect to: "/"
    else
      conn = Flash.put(conn, :warning, "Please re-enter your password")
      messages = Flash.get(conn)
      render conn, "new.html", %{title: "Log In", flash_messages: messages}
    end
  end

end