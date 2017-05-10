defmodule HelloCluster do
  use GenServer

  def start_link(status_message) do
    name = "Donal Trump is in WHITE HOUSE!"
    GenServer.start_link(__MODULE__, [name], name: status_message)
  end

  def ping! do
    IO.puts "Updating Trump Status"
    Phoenix.PubSub.broadcast(PhoenixLibcluster.PubSub, "hello:status", :refresh)
  end

  def init([name]) do
    send self, :register
    { :ok, name }
  end

  def get(status_message) do
    GenServer.call(status_message, :get)
  end

  def handle_info(:register, state) do
    Phoenix.PubSub.subscribe(PhoenixLibcluster.PubSub, "hello:status")
    IO.puts "Registered #{state} in PubSub"
    { :noreply, state}
  end

  def handle_info(:refresh, state) do
    state = "Donal Trump is in MOSCOW"
    IO.puts "Message: #{state}!"

    { :noreply, state }
  end

  def handle_call(:get, _from, state) do
    { :reply, state, state }
  end

end
