defmodule Flightex do

  alias Flightex.{Bookings, GenerateId, Users}
  alias Bookings.Agent, as: BookingAgent
  alias Users.Agent, as: UserAgent

  def start do
    GenerateId.start_link([])
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end
end
