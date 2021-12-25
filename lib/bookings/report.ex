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

  def generate_report(from_date, to_date) do
    content =
      Agent.list()
      |> Map.values()
      |> Enum.filter(&filter_by_interval(&1, from_date, to_date))
      |> parse()
      |> Enum.join("\n")

    with :ok <- File.write("report-bookings.csv", content) do
      {:ok, "Report generated successfully"}
    end
  end

  defp filter_by_interval(%Booking{complete_date: complete_date}, from_date, to_date) do
    Date.range(from_date, to_date)
    |> Enum.member?(NaiveDateTime.to_date(complete_date))
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
