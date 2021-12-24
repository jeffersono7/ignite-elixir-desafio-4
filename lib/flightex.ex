defmodule Flightex do

  alias Flightex.{GenerateId, Users}
  alias Users.Agent, as: UserAgent

  def start do
    GenerateId.start_link([])
    UserAgent.start_link(%{})
  end
end
