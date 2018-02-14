defmodule BudgetApp.Operations.ExchangeRate.DeleteTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.ExchangeRate.Delete
  alias BudgetApp.ExchangeRate
  alias BudgetApp.Repo

  test "removes record from the DB" do
    exchange_rate = insert(:exchange_rate)
    assert Repo.aggregate(ExchangeRate, :count, :id) == 1
    Delete.exec(exchange_rate.id)
    assert Repo.aggregate(ExchangeRate, :count, :id) == 0
  end

  test "raises exception when exchange rate ID not found" do
    assert {:error, _} = Delete.exec(1)
  end
end