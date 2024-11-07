defmodule Seven.Journal do
  @moduledoc "All code regarding endpoint /journal belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "journal"

  @enforce_keys [:from, :id, :price, :text, :timestamp, :to]
  defstruct [
    :connection,
    :dlr,
    :dlr_timestamp,
    :duration,
    :error,
    :foreign_id,
    :from,
    :id,
    :label,
    :latency,
    :mccmnc,
    :price,
    :status,
    :text,
    :timestamp,
    :to,
    :type,
    :xml,
  ]

  def new(attributes) do
    %__MODULE__{
      connection: attributes[:connection],
      dlr: attributes[:dlr],
      dlr_timestamp: attributes[:dlr_timestamp],
      duration: attributes[:duration],
      error: attributes[:error],
      foreign_id: attributes[:foreign_id],
      from: attributes[:from],
      id: attributes[:id],
      label: attributes[:label],
      latency: attributes[:latency],
      mccmnc: attributes[:mccmnc],
      price: attributes[:price],
      status: attributes[:status],
      text: attributes[:text],
      timestamp: attributes[:timestamp],
      to: attributes[:to],
      type: attributes[:type],
      xml: attributes[:xml],
    }
  end

  @spec inbound(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def inbound(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "/inbound?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec inbound!(map()) :: [map()]
  def inbound!(params) do
    {:ok, analytics} = inbound(params)
    analytics
  end

  @spec outbound(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def outbound(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "/outbound?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec outbound!(map()) :: [map()]
  def outbound!(params) do
    {:ok, analytics} = outbound(params)
    analytics
  end

  @spec replies(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def replies(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "/replies?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec replies!(map()) :: [map()]
  def replies!(params) do
    {:ok, analytics} = replies(params)
    analytics
  end

  @spec voice(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def voice(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "/voice?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Enum.map(body, fn a -> new(a) end)}

      {:ok, %Response{status_code: _, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  @spec voice!(map()) :: [map()]
  def voice!(params) do
    {:ok, analytics} = voice(params)
    analytics
  end
end
