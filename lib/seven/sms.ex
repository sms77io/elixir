defmodule Seven.Sms do
  @moduledoc "All code regarding endpoint /sms belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "sms"

  @spec delete(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def delete(params) do
    case HTTPClient.delete("sms?ids=" <> Jason.encode!(params)) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(map()) :: map()
  def delete!(params) do
    {:ok, response} = delete(params)
    response
  end

  @spec dispatch(map()) :: {:ok, String.t() | map()} | {:error, HTTPoison.Error | any()}
  def dispatch(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}

      {:ok, %Response{status_code: _, body: body}} -> {:error, body}

      {:error, error} -> {:error, error}
    end
  end

  @spec dispatch!(map()) :: String.t() | map()
  def dispatch!(params) do
    {:ok, response} = dispatch(params)
    response
  end
end
