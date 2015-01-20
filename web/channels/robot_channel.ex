defmodule Isis.RobotChannel do
  use Phoenix.Channel

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic

  Possible Return Values

  {:ok, socket} to authorize subscription for channel for requested topic

  {:error, socket, reason} to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join(socket, "lobby", message) do
    IO.puts "JOIN #{socket.channel}:#{socket.topic}"
    reply socket, "join", %{status: "connected"}
    
    case Node.list do
      [] ->
        IO.puts "No robots connected"
      _ ->
        # command
        robot_node = hd(Node.list)
        # cmd = "/bin/bash /root/horus/robot-scripts/modular-science/experiment.sh"
        cmd = "/bin/bash /Users/luisbebop/Documents/arcturusbiocloud/horus/robot-scripts/modular-science/experiment.sh"
        spawn(Isis.RobotChannel, :streaming_out, [cmd, robot_node, socket])
        # live streaming
        Horus.Client.camera_streaming(:start, robot_node)
    end
      
    {:ok, socket}
  end

  def join(socket, _private_topic, _message) do
    {:error, socket, :unauthorized}
  end
  
  def streaming_out(cmd, node, socket) do
    out = Horus.Client.get_output(cmd, node)
    
    case out do
      :error ->
        IO.puts "No more output from the process"
      {:ok, line} ->
        Phoenix.Channel.reply(socket, "new:msg", %{msg: line})
        streaming_out(cmd, node, socket)
    end
  end  
end
