defmodule Seven.JournalTest do
  @moduledoc "All tests regarding endpoint /journal belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Journal

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :journal_outbound
  test "returns a list of outbound journals on success" do
    use_cassette "journal_outbound" do
      for journal <- Journal.outbound!(%{}) do
        assert Map.has_key?(journal, :connection)
        assert Map.has_key?(journal, :dlr)
        assert Map.has_key?(journal, :dlr_timestamp)
        assert Map.has_key?(journal, :foreign_id)
        assert Map.has_key?(journal, :from)
        assert Map.has_key?(journal, :id)
        assert Map.has_key?(journal, :label)
        assert Map.has_key?(journal, :latency)
        assert Map.has_key?(journal, :mccmnc)
        assert Map.has_key?(journal, :price)
        assert Map.has_key?(journal, :text)
        assert Map.has_key?(journal, :timestamp)
        assert Map.has_key?(journal, :to)
        assert Map.has_key?(journal, :type)
      end
    end
  end

  @tag :journal_inbound
  test "returns a list of inbound journals on success" do
    use_cassette "journal_inbound" do
      for journal <- Journal.inbound!(%{}) do
        assert Map.has_key?(journal, :from)
        assert Map.has_key?(journal, :id)
        assert Map.has_key?(journal, :price)
        assert Map.has_key?(journal, :text)
        assert Map.has_key?(journal, :timestamp)
        assert Map.has_key?(journal, :to)
      end
    end
  end

  @tag :journal_replies
  test "returns a list of reply journals on success" do
    use_cassette "journal_replies" do
      for journal <- Journal.replies!(%{}) do
        assert Map.has_key?(journal, :from)
        assert Map.has_key?(journal, :id)
        assert Map.has_key?(journal, :price)
        assert Map.has_key?(journal, :text)
        assert Map.has_key?(journal, :timestamp)
        assert Map.has_key?(journal, :to)
      end
    end
  end

  @tag :journal_voice
  test "returns a list of voice journals on success" do
    use_cassette "journal_voice" do
      for journal <- Journal.voice!(%{}) do
        assert Map.has_key?(journal, :duration)
        assert Map.has_key?(journal, :error)
        assert Map.has_key?(journal, :from)
        assert Map.has_key?(journal, :id)
        assert Map.has_key?(journal, :price)
        assert Map.has_key?(journal, :status)
        assert Map.has_key?(journal, :text)
        assert Map.has_key?(journal, :timestamp)
        assert Map.has_key?(journal, :to)
        assert Map.has_key?(journal, :xml)
      end
    end
  end
end
