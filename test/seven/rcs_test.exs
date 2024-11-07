defmodule Seven.RCSTest do
  @moduledoc "All tests regarding endpoint /rcs belong here."

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.RCS

  setup_all do
    HTTPoison.start()
  end

  @tag :rcs_delete
  test "returns an error because no IDs supplied" do
    use_cassette "rcs_delete" do
      response = RCS.delete!("")

      assert false === response.success
    end
  end

  @tag :rcs_event_to
  test "returns an error because the phone number is not in use" do
    use_cassette "rcs_event_to" do
      response = RCS.event!(%{"event" => "IS_TYPING", "to" => "49176123456789"})

      assert false === response.success
    end
  end

  @tag :rcs_event_msg_id
  test "returns an error because the msg_id is wrong" do
    use_cassette "rcs_event_msg_id" do
      response = RCS.event!(%{"event" => "READ", "msg_id" => ""})

      assert false === response.success
    end
  end

  @tag :rcs_send_delete
  test "prepares rcs and deletes it again" do
    use_cassette "rcs_send_delete" do
      rcs = RCS.dispatch!(%{"to" => "491716992343", "text" => "HI2U", "delay" => "2050-12-12 00:00:00"})

      assert "100" === rcs.success

      msg = Enum.at(rcs.messages, 0)

      Process.sleep(1000)

      deleted = RCS.delete!(msg.id)
      assert deleted.success
    end
  end
end
