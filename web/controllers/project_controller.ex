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
    # talking with the robots on the lab. by now we just have 1 robot
    case Node.list do
      [] ->
        IO.puts "No robots connected"
      _ ->
        robot_node = hd(Node.list)
        Horus.Client.stop_shell("ping www.google.com", robot_node)
        Horus.Client.shell("ping www.google.com", robot_node)
    end

    conn = Flash.put(conn, :notice, "Project created. Arc is working for you. Check the live streaming.")
    messages = Flash.get(conn)
    render conn, "new.html", %{title: "Project Live Streaming", flash_messages: messages, livestreaming: true}
  end

end