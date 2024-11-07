defmodule Seven.ContactsTest do
  @moduledoc "All tests regarding endpoint /groups belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Groups}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :contacts
  test "create, update, get, list, delete a group" do
    use_cassette "groups" do
      created = Groups.create!("Elixir")
      assert created.id > 0
      assert Map.has_key?(created, :id)
      assert Map.has_key?(created, :name)
      assert Map.has_key?(created, :members_count)
      assert Map.has_key?(created, :created)

      group = Groups.get!(created.id)
      assert created.id === group.id

      groups = Groups.list!(%{limit: nil, offset: nil})
      filtered = Enum.filter(groups.data, fn(x) -> x.id === created.id end)
      assert 1 === length(filtered)

      updated = Groups.update!(%{id: created.id, name: "Elixir New"})
      assert created.name !== updated.name

      deleted = Groups.delete!(created.id, true)
      assert deleted.success
    end
  end
end
