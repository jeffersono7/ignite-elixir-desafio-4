defmodule Flightex.Bookings.Agent do
  use Agent

  alias Flightex.Bookings.Booking

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec save(%Booking{}) :: {:ok, binary()}
  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &save_booking(&1, id, booking))

    {:ok, id}
  end

  @spec get(binary()) :: {:ok, %Booking{}} | {:error, binary()}
  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  @spec list :: map()
  def list, do: Agent.get(__MODULE__, & &1)

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp save_booking(state, id, booking) do
    Map.put(state, id, booking)
  end
end
