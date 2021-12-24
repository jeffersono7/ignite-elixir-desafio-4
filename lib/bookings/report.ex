defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.{Agent, Booking}

  def generate(filename) do
    content =
      Agent.list()
      |> Map.values()
      |> parse()
      |> Enum.join("\n")

    File.write!(filename, content)
  end

  defp parse(list) do
    for %Booking{
          user_id: user_id,
          local_origin: origin,
          local_destination: destination,
          complete_date: date
        } <- list do
      date_formatted = NaiveDateTime.to_string(date)

      "#{user_id},#{origin},#{destination},#{date_formatted}"
    end
  end
end
