defmodule Seven.Contacts do
  @moduledoc "All code regarding endpoint /contacts belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "contacts"

  @spec list(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def list(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "?#{qs}") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec list!(map()) :: [map()]
  def list!(params) do
    {:ok, response} = list(params)
    response
  end

  @spec get(pos_integer()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def get(id) do
    case HTTPClient.get(@endpoint <> "/#{id}") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec get!(pos_integer()) :: map()
  def get!(id) do
    {:ok, response} = get(id)
    response
  end

  @spec create(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def create(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec create!(map()) :: map()
  def create!(params) do
    {:ok, response} = create(params)
    response
  end

  @spec update(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def update(params) do
    case HTTPClient.patch(@endpoint <> "/#{params.id}", {:form, Map.to_list(Map.delete(params, :id))}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec update!(map()) :: map()
  def update!(params) do
    {:ok, response} = update(params)
    response
  end

  @spec delete(pos_integer()) :: {:ok, none()} | {:error, HTTPoison.Error | any()}
  def delete(id) do
    case HTTPClient.delete(@endpoint <> "/#{id}") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(pos_integer()) :: none()
  def delete!(id) do
    {:ok, response} = delete(id)
    response
  end
end
