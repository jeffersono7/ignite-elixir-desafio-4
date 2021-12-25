defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Report

  describe "generate/1" do
    test "when called, return the content" do
      params = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
        id: UUID.uuid4()
      }

      content = "12345678900,Brasilia,Bananeiras,2001-05-07 12:00:00"

      Flightex.create_or_update_booking(params)
      Report.generate("report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      assert file =~ content
    end
  end

  describe "generate_report/2" do
    test "when given from and to date, generate file with report" do
      params1 = %{
        complete_date: ~N/2021-11-30 10:30:02/,
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900",
      }

      params2 = Map.put(params1, :complete_date, ~N[2021-12-01 12:00:00])

      params3 =
        Map.put(params1, :complete_date, ~N/2021-12-08 12:00:00/)
        |> Map.put(:local_destination, "Sao Paulo")

      Flightex.create_or_update_booking(params1)
      Flightex.create_or_update_booking(params2)
      Flightex.create_or_update_booking(params3)

      from_date = Date.new!(2021, 12, 1)
      to_date = Date.new!(2021, 12, 30)

      content =
        "12345678900,Brasilia,Bananeiras,2021-12-01 12:00:00\n" <>
          "12345678900,Brasilia,Sao Paulo,2021-12-08 12:00:00"

      {:ok, "Report generated successfully"} = Flightex.generate_report(from_date, to_date)

      {:ok, file} = File.read("report-bookings.csv")

      assert file == content
    end
  end
end
