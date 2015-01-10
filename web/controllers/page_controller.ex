defmodule Isis.PageController do
  use Isis.Helper.Application

  plug :action

  def index(conn, _params) do
    render conn, "index.html", %{title: "Welcome"}
  end
end
