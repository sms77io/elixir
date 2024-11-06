defmodule Seven.Lookup do
  @moduledoc "All code regarding endpoint /lookup belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "lookup"

  @spec cnam(String.t()) :: {:ok, map() | [map()]} | {:error, HTTPoison.Error | any()}
  def cnam(number) do
    case HTTPClient.get(@endpoint <> "/cnam?number=" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec cnam!(String.t()) :: map() | [map()]
  def cnam!(number) do
    {:ok, response} = cnam(number)
    response
  end

  @spec format(String.t()) :: {:ok, map() | [map()]} | {:error, HTTPoison.Error | any()}
  def format(number) do
    case HTTPClient.get(@endpoint <> "/format?number=" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec format!(String.t()) :: map() | [map()]
  def format!(number) do
    {:ok, response} = format(number)
    response
  end

  @spec hlr(String.t()) :: {:ok, map() | [map()]} | {:error, HTTPoison.Error | any()}
  def hlr(number) do
    case HTTPClient.get(@endpoint <> "/hlr?number=" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec hlr!(String.t()) :: map() | [map()]
  def hlr!(number) do
    {:ok, response} = hlr(number)
    response
  end

  @spec mnp(String.t()) :: {:ok, map() | [map()]} | {:error, HTTPoison.Error | any()}
  def mnp(number) do
    case HTTPClient.get(@endpoint <> "/mnp?number=" <> number) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec mnp!(String.t()) :: map() | [map()]
  def mnp!(number) do
    {:ok, response} = mnp(number)
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
