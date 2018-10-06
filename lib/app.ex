defmodule App do

  require Logger

  def accept(port) do
    Chat.start_link()
    {:ok, socket} = 
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    pid = spawn(fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_line()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0, 5*60*1000) do
      {:ok, data} -> Chat.new_msg(data)
      {:error, :closed} -> Process.exit(self(), :closed)
      {:error, :timeout} -> Process.exit(self(), :timeout)
    end
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, Chat.get_chat())
  end
end