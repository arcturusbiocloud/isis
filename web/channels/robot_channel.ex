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
        robot_node = hd(Node.list)
        proc = Horus.Client.get_shell("ping www.google.com", robot_node)
        if proc != nil, do: spawn(fn() -> for line <- proc.proc.out do Phoenix.Channel.reply(socket, "new:msg", %{msg: line}) end end)
    end
      
    {:ok, socket}
  end

  def join(socket, _private_topic, _message) do
    {:error, socket, :unauthorized}
  end
end
