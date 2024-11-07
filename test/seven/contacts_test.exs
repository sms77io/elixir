defmodule Seven.ContactsTest do
  @moduledoc "All tests regarding endpoint /contacts belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Contacts}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :contacts
  test "create, update, get, list, delete contact(s)" do
    use_cassette "contacts" do
      created = Contacts.create!(%{firstname: "Tim", lastname: "Testerson"})
      assert created.id > 0
      assert Map.has_key?(created, :properties)

      contact = Contacts.get!(created.id)
      assert created.id === contact.id

      contacts = Contacts.list!(%{limit: 1, search: "Testerson"})
      filtered = Enum.filter(contacts.data, fn(x) -> x.id === created.id end)
      assert 1 === length(filtered)

      updated = Contacts.update!(%{id: created.id, firstname: "Timmy"})
      assert created.properties.firstname !== updated.properties.firstname
      Contacts.delete!(created.id)
    end
  end
end
