defmodule Seven.BalanceTest do
  @moduledoc "All tests regarding endpoint /balance belong here."

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Seven.Balance

  setup_all do
    HTTPoison.start
    :ok
  end

  @tag :balance
  test "returns balance or error" do
    use_cassette "balance" do
      tuple = Balance.get()
      status = elem(tuple, 0)
      balance = elem(tuple, 1)

      assert status === :error or status === :ok

       if (status === :ok) do
         assert balance.currency === "EUR"
       end
    end
  end

  @tag :balance!
  test "returns balance on success" do
    use_cassette "balance!" do
      balance = Balance.get!()
      assert balance.currency === "EUR"
    end
  end
end
