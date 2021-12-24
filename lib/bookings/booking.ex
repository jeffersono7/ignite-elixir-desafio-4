defmodule Flightex.Bookings.Booking do

  alias Flightex.GenerateId

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]

  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) do
    id = GenerateId.call()

    booking = %__MODULE__{
      complete_date: complete_date,
      local_origin: local_origin,
      local_destination: local_destination,
      user_id: user_id,
      id: id
    }

    {:ok, booking}
  end
end
