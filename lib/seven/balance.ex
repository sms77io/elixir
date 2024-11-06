defmodule Seven.Balance do
  @moduledoc "All code regarding endpoint /balance belongs here."

  alias HTTPoison.Response
  alias Seven.HTTPClient

  @endpoint "balance"

  @spec get() :: {:ok, map()} | {:error, HTTPoison.Error | any()}
  def get() do
    case HTTPClient.get(@endpoint) do
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: _, body: body}} -> {:error, body}
      {:error, error} -> {:error, error}
    end
  end

  @spec get!() :: map()
  def get!() do
    {:ok, balance} = get()
    balance
  end
end
