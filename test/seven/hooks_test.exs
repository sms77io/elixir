defmodule Seven.HooksTest do
  @moduledoc "All tests regarding endpoint /hooks belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Hooks

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :hooks_read
  test "returns a list of hooks on success" do
    use_cassette "hooks_read" do
      map = Hooks.list!()

      assert true === map.success

      for hook <- map.hooks do
        assert Map.has_key?(hook, :id)
        assert Map.has_key?(hook, :target_url)
        assert Map.has_key?(hook, :event_type)
        assert Map.has_key?(hook, :request_method)
        assert Map.has_key?(hook, :created)
      end
    end
  end

  @tag :hooks_subscribe_fail
  test "subscribe_fail: returns a map on success" do
    use_cassette "hooks_subscribe_fail" do
      params = %{
        event_type: "all",
        target_url: "ThisShouldBeAUrl",
      }
      map = Hooks.subscribe!(params)

      assert false === map.success
      assert false === Map.has_key?(map, :id)
    end
  end

  @tag :hooks_subscribe
  test "subscribe: returns a map on success" do
    use_cassette "hooks_subscribe" do
      map = Hooks.subscribe!(
        %{
          event_type: "all",
          request_method: "POST",
          target_url: "https://my.tld/#{UUID.uuid4()}",
        }
      )

      Hooks.unsubscribe!(map.id)

      assert true === map.success
      assert 0 < map.id
    end
  end

  @tag :hooks_unsubscribe
  test "unsubscribe: returns a map on success" do
    use_cassette "hooks_unsubscribe" do
      hook = Hooks.subscribe!(
        %{
          event_type: "all",
          request_method: "POST",
          target_url: "https://my.tld/#{UUID.uuid4()}",
        }
      )

      res = Hooks.unsubscribe!(hook.id)
      assert true === res.success
    end
  end
end
