defmodule Seven.Hooks do
  @moduledoc "All code regarding endpoint /hooks belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "hooks"

  @spec unsubscribe(pos_integer()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def unsubscribe(id) do
    case HTTPClient.delete(@endpoint <> "?id=" <> id) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec unsubscribe!(pos_integer()) :: map()
  def unsubscribe!(id) do
    {:ok, response} = unsubscribe(id)
    response
  end

  @spec list() :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def list() do
    case HTTPClient.get(@endpoint) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec list!() :: map()
  def list!() do
    {:ok, response} = list()
    response
  end

  @spec subscribe(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def subscribe(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec subscribe!(map()) :: map()
  def subscribe!(params) do
    {:ok, response} = subscribe(params)
    response
  end
end
