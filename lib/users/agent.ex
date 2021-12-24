defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{cpf: cpf} = user), do: Agent.update(__MODULE__, &save_user(&1, cpf, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case state do
      %{^cpf => user} -> {:ok, user}
      _ -> {:error, "User not found"}
    end
  end

  defp save_user(state, cpf, user) do
    Map.put(state, cpf, user)
  end
end
