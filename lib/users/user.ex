defmodule Flightex.Users.User do

  alias Flightex.GenerateId

  @keys [:name, :email, :cpf, :id]

  @enforce_keys @keys
  defstruct @keys

  def build(name, email, cpf) when is_bitstring(cpf) do
    id = GenerateId.call()

    {:ok, %__MODULE__{name: name, cpf: cpf, email: email, id: id}}
  end

  def build(_name, _email, _cpf), do: {:error, "Cpf must be a String"}
end
