defmodule Seven.Lookup do
  @moduledoc "All code regarding endpoint /lookup belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "lookup"

  @spec post(map()) :: {:ok, String.t() | map() | [map()]} | {:error, HTTPoison.Error | any()}
  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec post!(map()) :: String.t() | map() | [map()]
  def post!(params) do
    {:ok, response} = post(params)
    response
  end

  @spec rcs(String.t()) :: {:ok, map() | [map()]} | {:error, HTTPoison.Error | any()}
  def rcs(number) do
    case HTTPClient.get(@endpoint <> "/rcs?number=" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec rcs!(String.t()) :: map() | [map()]
  def rcs!(number) do
    {:ok, response} = rcs(number)
    response
  end
end
