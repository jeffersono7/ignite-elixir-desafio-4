defmodule Flightex.GenerateIdTest do
  use ExUnit.Case

  alias Flightex.GenerateId

  describe "next/0" do
    test "when call next, increment id and return ok" do
      before_id = GenerateId.call()

      GenerateId.next()

      after_id = GenerateId.call()

      assert before_id + 2 == after_id
    end
  end
end
