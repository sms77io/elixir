defmodule Seven.NumbersTest do
  @moduledoc "All tests regarding endpoint /groups belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Numbers}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :numbers
  test "list available, order, list active, get, update, delete number" do
    use_cassette "numbers" do
      available = Numbers.listAvailable!(%{"country" => "de", "features_a2p_sms" => true})
      assert Map.has_key?(available, :availableNumbers)
      assert length(available.availableNumbers) > 0
      available = Enum.at(available.availableNumbers, 0)

      ordered = Numbers.order!(%{"number" => available.number, "payment_interval" => "monthly"})
      assert ordered.success
      assert nil == ordered.error

      active = Numbers.getActive!(available.number)
      assert active.number === available.number

      actives = Numbers.listActive!()
      actives = Enum.filter(actives.activeNumbers, fn(x) -> x.number === active.number end)
      assert length(actives) === 1

      updated = Numbers.update!(%{"number" => active.number, "friendly_name" => "New Friendly Name"})
      assert updated.friendly_name !== active.friendly_name

      deleted = Numbers.delete!(active.number, true)
      assert deleted.success
    end
  end
end
