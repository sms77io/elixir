defmodule Seven.SmsTest do
  @moduledoc "All tests regarding endpoint /sms belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Sms

  setup_all do
    HTTPoison.start()
  end

  @tag :sms_delete
  test "returns an error because no IDs supplied" do
    use_cassette "sms_delete" do
      response = Sms.delete!(%{
        ids: [], # empty list
      })

      assert false === response.success
      assert nil === response.deleted
    end
  end

  @tag :sms_json
  test "returns a map on success" do
    use_cassette "sms_json" do
      params = %{
        delay: "2050-12-12 00:00:00",
        from: "Elixir",
        text: "HI2U!",
        to: "+49179999999999",
      }
      response = Sms.dispatch!(params)

      assert Map.has_key?(response, :debug)
      assert "direct" === response.sms_type
      assert "100" === response.success
      assert response.total_price >= 0

      for message <- response.messages do
        assert "gsm" === message.encoding
        assert nil === message.error
        assert nil === message.error_text
        assert Map.has_key?(message, :id)
        assert nil === message.label
        assert 1 === message.parts
        assert Map.has_key?(message, :price)
        assert String.replace(Map.get(params, :to), "+", "") === message.recipient
        assert Map.get(params, :from) === message.sender
        assert true === message.success
        assert Map.get(params, :text) === message.text
      end
    end
  end
end
