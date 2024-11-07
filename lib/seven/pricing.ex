defmodule Seven.Pricing do
  @moduledoc "All code regarding endpoint /pricing belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "pricing"

  @spec get(map()) :: {:ok, String.t() | map()} | {:error, HTTPoison.Error | any()}
  def get(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec get!(map()) :: String.t() | map()
  def get!(params) do
    {:ok, response} = get(params)
    response
  end
end
