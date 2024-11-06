defmodule Seven.Numbers do
  @moduledoc "All code regarding endpoint /numbers belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "numbers"

  @spec listAvailable(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def listAvailable(params) do
    qs = URI.encode_query(params)

    case HTTPClient.get(@endpoint <> "/available?" <> qs) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec listAvailable!(map()) :: map()
  def listAvailable!(params) do
    {:ok, response} = listAvailable(params)
    response
  end

  @spec listActive() :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def listActive() do
    case HTTPClient.get(@endpoint <> "/active") do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec listActive!() :: map()
  def listActive!() do
    {:ok, response} = listActive()
    response
  end

  @spec getActive(String.t()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def getActive(number) do
    case HTTPClient.get(@endpoint <> "/active/" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec getActive!(String.t()) :: map()
  def getActive!(number) do
    {:ok, response} = getActive(number)
    response
  end

  @spec order(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def order(params) do
    case HTTPClient.post(@endpoint, {:form, Map.to_list(params)}) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec order!(map()) :: map()
  def order!(params) do
    {:ok, response} = order(params)
    response
  end

  @spec update(map()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def update(params) do
    case HTTPClient.patch(@endpoint <> "/active/" <> params.number, {:form, Map.to_list(Map.delete(params, :number))}) do
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

  @spec delete(String.t(), boolean()) :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def delete(number, delete_immediately) do
    case HTTPClient.delete(@endpoint <> "/active/" <> number <> "?delete_immediately=" <> delete_immediately) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec delete!(String.t(), boolean()) :: map()
  def delete!(number, delete_immediately) do
    {:ok, response} = delete(number, delete_immediately)
    response
  end
end
