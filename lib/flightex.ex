defmodule Flightex do

  alias Flightex.GenerateId

  def start do
    GenerateId.start_link([])
  end
end
