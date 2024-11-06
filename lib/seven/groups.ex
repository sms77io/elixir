defmodule Seven.Groups do
  @moduledoc "All code regarding endpoint /groups belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "groups"

  @spec get(pos_integer()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def get(id) do
    case HTTPClient.get(@endpoint <> "/" <> id) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec get!(pos_integer()) :: any()
  def get!(id) do
    {:ok, response} = get(id)
    response
  end

  @spec create(String.t()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def create(name) do
    case HTTPClient.post(@endpoint, {:form, %{"name" => name}}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec create!(String.t()) :: any()
  def create!(name) do
    {:ok, response} = create(name)
    response
  end

  @spec list(map()) :: {:ok, [map()]} | {:error, HTTPoison.Error | any()}
  def list(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "?" <> qs) do
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

  @spec update(String.t()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def update(name) do
    case HTTPClient.patch(@endpoint, {:form, %{"name" => name}}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec update!(String.t()) :: any()
  def update!(name) do
    {:ok, response} = update(name)
    response
  end

  @spec delete(pos_integer(), boolean()) :: {:ok, any()} | {:error, HTTPoison.Error | any()}
  def delete(id, delete_contacts) do
    case HTTPClient.delete(@endpoint <> "/" <> id, {:form, %{"delete_contacts" => delete_contacts}}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(pos_integer(), boolean()) :: any()
  def delete!(id, delete_contacts) do
    {:ok, response} = delete(id, delete_contacts)
    response
  end
end
