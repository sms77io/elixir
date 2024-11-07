defmodule Seven.AnalyticsTest do
  @moduledoc "All tests regarding endpoint /analytics belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Analytics

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :analytics_group_by_country
  test "returns a list of analytics grouped by country on success" do
    use_cassette "analytics_group_by_country" do
      list = Analytics.groupedByCountry!(%{})
      for analytic <- list do
        assert Map.has_key?(analytic, :country)
      end
    end
  end

  @tag :analytics_group_by_date
  test "returns a list of analytics grouped by date on success" do
    use_cassette "analytics_group_by_date" do
      list = Analytics.groupedByDate!(%{})
      for analytic <- list do
        assert Map.has_key?(analytic, :date)
      end
    end
  end

  @tag :analytics_group_by_subaccount
  test "returns a list of analytics grouped by subaccount on success" do
    use_cassette "analytics_group_by_subaccount" do
      list = Analytics.groupedBySubaccount!(%{})
      for analytic <- list do
        assert Map.has_key?(analytic, :account)
      end
    end
  end

  @tag :analytics_group_by_label
  test "returns a list of analytics grouped by label on success" do
    use_cassette "analytics_group_by_label" do
      list = Analytics.groupedByLabel!(%{})
      for analytic <- list do
        assert Map.has_key?(analytic, :label)
      end
    end
  end

  @tag :analytics_group_by_label_for_label
  test "returns a list of analytics grouped by label for a certain label on success" do
    use_cassette "analytics_group_by_label_for_label" do
      list =Analytics.groupedByLabel!(%{label: "xxx"})
      for analytic <- list do
        assert Map.has_key?(analytic, :label)
      end
    end
  end
end
