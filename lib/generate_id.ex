defmodule Flightex.GenerateId do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, 1, name: __MODULE__)
  end

  @spec call :: integer()
  def call, do: GenServer.call(__MODULE__, :get)

  @spec next :: :ok
  def next, do: GenServer.cast(__MODULE__, :next)

  # Server

  @impl true
  def init(_opts) do
    {:ok, 1}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state + 1}
  end

  @impl true
  def handle_cast(:next, state) do
    {:noreply, state + 1}
  end
end
