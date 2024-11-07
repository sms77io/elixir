defmodule Seven.RCS do
  @moduledoc "All code regarding endpoint /rcs belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "rcs"

  @spec dispatch(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def dispatch(params) do
    case HTTPClient.post(@endpoint <> "/messages", {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec dispatch!(map()) :: map()
  def dispatch!(params) do
    {:ok, response} = dispatch(params)
    response
  end

  @spec delete(String.t()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def delete(id) do
    case HTTPClient.delete(@endpoint <> "/messages/#{id}") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(String.t()) :: map()
  def delete!(id) do
    {:ok, response} = delete(id)
    response
  end

  @spec event(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def event(params) do
    case HTTPClient.post(@endpoint <> "/events", {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec event!(map()) :: map()
  def event!(params) do
    {:ok, response} = event(params)
    response
  end
end
