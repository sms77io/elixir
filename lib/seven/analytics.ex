defmodule Seven.Analytics do
  @moduledoc "All code regarding endpoint /analytics belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "analytics/"

  @type group_by :: :country | :date | :label | :subaccount
  @type params :: {
    group_by :: String.t(),
    start :: String.t(),
    end_ :: String.t(),
    label :: String.t(),
    subaccounts :: String.t(),
  }

  @enforce_keys [
    :hlr,
    :inbound,
    :mnp,
    :sms,
    :usage_eur,
    :voice
  ]

  defstruct [
    :account, # TODO?
    :country, # TODO?
    :date, # TODO?
    :hlr,
    :inbound,
    :label, # TODO?
    :mnp,
    :rcs,
    :sms,
    :usage_eur,
    :voice,
  ]

  def new(attributes) do
    %__MODULE__{
      account: attributes[:account], # TODO?
      country: attributes[:country], # TODO?
      date: attributes[:date], # TODO?
      hlr: attributes[:hlr],
      inbound: attributes[:inbound],
      label: attributes[:label], # TODO?
      mnp: attributes[:mnp],
      rcs: attributes[:rcs],
      sms: attributes[:sms],
      usage_eur: attributes[:usage_eur],
      voice: attributes[:voice],
    }
  end

  @spec get(String.t(), map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def get(group_by, params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> group_by <> "?" <> qs) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, Enum.map(body, fn a -> new(a) end)}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec get!(String.t(), map()) :: [map()]
  def get!(group_by, params) do
    {:ok, analytics} = get(group_by, params)
    analytics
  end

  @spec groupedByCountry!(map()) :: [map()]
  def groupedByCountry!(params) do
    get!("country", params)
  end

  @spec groupedByDate!(map()) :: [map()]
  def groupedByDate!(params) do
    get!("date", params)
  end

  @spec groupedByLabel!(map()) :: [map()]
  def groupedByLabel!(params) do
    get!("label", params)
  end

  @spec groupedBySubaccount!(map()) :: [map()]
  def groupedBySubaccount!(params) do
    get!("subaccount", params)
  end
end
