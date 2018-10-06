defmodule Chat do
  
  use GenServer

  def init(state \\ []) do
    {:ok, state}
  end

  def handle_call({:store, msg}, _from, state) do
    new_state = shorten_chat([msg | state])
    {:reply, :ok, new_state}
  end

  def handle_call(:fetch, _from, state) do
    {:reply, state |> Enum.reverse |> Enum.join(" "), state}
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_chat() do
    GenServer.call(__MODULE__, :fetch)
  end

  def new_msg(msg) do
    GenServer.call(__MODULE__, {:store, msg})
  end

  def shorten_chat(chat_history) do
    case length(chat_history) > 100 do
      true -> 
        chat_history
        |> Enum.reverse
        |> Enum.slice(0,50)
        |> Enum.reverse
      false ->
        chat_history
    end
  end

end