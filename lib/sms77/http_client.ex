defmodule Sms77.HTTPClient do
  @moduledoc """
  Poison HTTP Client for Sms77
  """

  use HTTPoison.Base

  alias Sms77.Config

  @doc """
  Complete / Filter URL

  ### Examples

      iex> Application.put_env(:sms77, :api_key, "Your API key")
      iex> Sms77.HTTPClient.process_request_url("balance")
      "https://gateway.sms77.io/api/balance"

  """

  def process_request_url(endpoint) do
    "https://gateway.sms77.io/api/" <> endpoint
  end

  def process_response_body(body) do
    if body === "" do
      body
    else
      try do
        Jason.decode!(body, keys: :atoms)
      rescue
        e in Jason.DecodeError -> e.data
      end
    end
  end

  @doc """
  Add Auth Header to every request that has none already

  ### Examples

      iex> Application.put_env(:sms77, :api_key, "Your API key")
      iex> Sms77.HTTPClient.process_request_headers([])
      [{"X-Api-Key", "Your API key"}]

  """
  def process_request_headers(headers) do
    [{"X-Api-Key", Config.api_key!()}, {"SentWith", Config.sent_with!()} | headers]
  end
end