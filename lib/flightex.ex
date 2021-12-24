defmodule Flightex do
  use Application

  alias Flightex.{Bookings, GenerateId, Users}
  alias Bookings.Agent, as: BookingAgent
  alias Users.Agent, as: UserAgent

  defdelegate create_or_update_booking(params), to: Bookings.CreateOrUpdate, as: :call

  def start(_type, _args) do
    children = [GenerateId, BookingAgent, UserAgent]

    Supervisor.start_link(children, [strategy: :one_for_all])
  end
end
