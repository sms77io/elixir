defmodule Seven.Voice do
  @moduledoc "All code regarding endpoint /voice belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "voice"

  @spec post(map()) :: {:ok, String.t() | map()} | {:error, HTTPoison.Error | any()}
  def post(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec post!(map()) :: String.t() | map()
  def post!(params) do
    {:ok, response} = post(params)
    response
  end


  @spec hangup(String.t()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def hangup(call_id) do
    case HTTPClient.post(@endpoint <> "/#{call_id}/hangup", %{}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec hangup(String.t()) :: map()
  def hangup!(call_id) do
    {:ok, response} = hangup(call_id)
    response
  end
end
