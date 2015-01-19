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
        conn = Flash.put(conn, :warning, "Arc is sleeping. Send a message to my masters at team@arcturus.io")
        messages = Flash.get(conn)
        render conn, "new.html", %{title: "Project", flash_messages: messages, livestreaming: false}
      _ ->
        robot_node = hd(Node.list)
        cmd = "/bin/bash /root/horus/robot-scripts/modular-science/experiment.sh"
        Horus.Client.shell(cmd, robot_node)
                        
        conn = Flash.put(conn, :notice, "Project created. Arc is working for you. Check the live streaming.")
        messages = Flash.get(conn)
        render conn, "new.html", %{title: "Project", flash_messages: messages, livestreaming: true}
    end
  end

end