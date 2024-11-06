defmodule Seven.StatusTest do
  @moduledoc "All tests regarding endpoint /status belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Sms, Status, TestUtil}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :status
  test "returns a code on success" do
    use_cassette "status" do
      params = %{
        delay: "2050-12-12 00:00:00",
        from: "Elixir",
        text: "HI2U!",
        to: "+49179999999999",
      }
      response = Sms.dispatch!(params)
      msg = Enum.at(response.messages, 0)
      id = msg.id

      statuses = Status.get!(id)
      assert assert 1 === Enum.count(statuses)
      # status = statuses.first

      Sms.delete!(id)
    end
  end

  @tag :status_fail
  test "returns an error code" do
    use_cassette "status_fail" do
      status = Status.get!(0)
      IO.puts status
      assert 600 == status
    end
  end
end
