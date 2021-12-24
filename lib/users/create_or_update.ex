defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    with {:ok, user} <- User.build(name, email, cpf) do
      Agent.save(user)

      {:ok, user}
    end
  end
end
