defmodule Seven.LookupTest do
  @moduledoc "All tests regarding endpoint /lookup belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.{Lookup}

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :lookup_rcs
  test "rcs: returns a map on success" do
    use_cassette "lookup_rcs" do
      map = Lookup.rcs!("491716992343")

      assert "T-Mobile" === map.carrier
      assert "49" === map.country_code
      assert "DE" === map.country_iso
      assert "Germany" === map.country_name
      assert "+491716992343" === map.international
      assert "+49 171 6992343" === map.international_formatted
      assert "0171 6992343" === map.national
      assert "mobile" === map.network_type
      assert true === map.success
      assert true === Map.has_key?(map, :rcs_capabilities)
    end
  end

  @tag :lookup_format
  test "format: returns a map on success" do
    use_cassette "lookup_format" do
      params = %{
        number: "491716992343",
        type: "format",
      }
      map = Lookup.get!(params)

      assert "T-Mobile" === map.carrier
      assert "49" === map.country_code
      assert "DE" === map.country_iso
      assert "Germany" === map.country_name
      assert "+491716992343" === map.international
      assert "+49 171 6992343" === map.international_formatted
      assert "0171 6992343" === map.national
      assert "mobile" === map.network_type
      assert true === map.success
    end
  end

  @tag :lookup_mnp_json
  test "mnp: returns a map on success" do
    use_cassette "lookup_mnp_json" do
      params = %{
        json: 1,
        number: "491716992343",
        type: "mnp",
      }
      map = Lookup.get!(params)

      assert 100 === map.code
      assert "DE" === map.mnp.country
      assert "+49 171 6992343" === map.mnp.international_formatted
      assert false === map.mnp.isPorted
      assert "26201" === map.mnp.mccmnc
      assert "0171 6992343" === map.mnp.national_format
      assert "Telekom Deutschland GmbH" === map.mnp.network
      assert "+491716992343" === map.mnp.number
      assert 0.005 === map.price || 0 === map.price
      assert true === map.success
    end
  end

  @tag :lookup_mnp_text
  test "mnp: returns the operator on success" do
    use_cassette "lookup_mnp_text" do
      params = %{
        number: "491716992343",
        type: "mnp",
      }
      text = Lookup.get!(params)

      assert "d1" === text
    end
  end

  @tag :lookup_hlr
  test "hlr: returns a map on success" do
    use_cassette "lookup_hlr" do
      params = %{
        number: "491716992343",
        type: "hlr",
      }
      map = Lookup.get!(params)

      assert "DE" === map.country_code
      assert "Germany" === map.country_name
      assert "49" === map.country_prefix
      assert "DE" === map.current_carrier.country
      assert "Telekom Deutschland GmbH" === map.current_carrier.name
      assert "26201" === map.current_carrier.network_code
      assert "mobile" === map.current_carrier.network_type
      assert "0" === map.gsm_code
      assert "No error" === map.gsm_message
      assert "491716992343" === map.international_format_number
      assert "+49 171 6992343" === map.international_formatted
      assert true === map.lookup_outcome
      assert "success" === map.lookup_outcome_message
      assert "0171 6992343" === map.national_format_number
      assert "DE" === map.original_carrier.country
      assert "Telekom Deutschland GmbH" === map.original_carrier.name
      assert "26201" === map.original_carrier.network_code
      assert "mobile" === map.original_carrier.network_type
      assert "assumed_not_ported" === map.ported
      assert "reachable" === map.reachable
      assert "not_roaming" === map.roaming
      assert true === map.status
      assert "success" === map.status_message
      assert "valid" === map.valid_number
    end
  end

  @tag :lookup_cnam
  test "cnam: returns a map on success" do
    use_cassette "lookup_cnam" do
      params = %{
        number: "491716992343",
        type: "cnam",
      }
      map = Lookup.get!(params)

      assert "100" === map.code
      assert "GERMANY" === map.name
      assert "+491716992343" === map.number
      assert "true" === map.success
    end
  end
end
