defmodule Isis.ProjectController do
  use Isis.Helper.Application
  alias Isis.User
  alias Plug.Conn
  
  plug :authorize
  plug :action
  
  def new(conn, params) do
    render conn, "new.html", %{title: "Project"}
  end
  
  def create(conn, params) do
    conn = Flash.put(conn, :notice, "Project create. Check the live streaming.")
    messages = Flash.get(conn)
    render conn, "new.html", %{title: "Project Live Streaming", flash_messages: messages, livestreaming: true}
  end

end