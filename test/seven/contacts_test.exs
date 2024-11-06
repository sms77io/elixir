defmodule Seven.ContactsTest do
  @moduledoc "All tests regarding endpoint /contacts belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Contacts, TestUtil}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :contacts
  test "create, update, get, list, delete contact(s)" do
    use_cassette "contacts" do
      created = Contacts.create!(%{firstname: "Tim", lastname: "Testerson"})
      IO.puts created.id
#      inspect(created)

      contact = Contacts.get!(created.id)
      IO.puts contact
      assert created.id === contact.id
      contacts = Contacts.list!(%{limit: 1, search: "Testerson"})
      assert 1 === length(contacts.data)
      updated = Contacts.create!(%{id: created.id, firstname: "Timmy"})
      assert created.firstname !== updated.firstname
      Contacts.delete!(created.id)

#      for contact <- list do
#        assert 0 < String.to_integer(Map.get(contact, :ID))
#        assert Map.has_key?(contact, :Name)
#        assert Map.has_key?(contact, :Number)
#      end
    end
  end
end
