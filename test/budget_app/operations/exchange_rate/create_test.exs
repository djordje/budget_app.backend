defmodule BudgetApp.Operations.ExchangeRate.CreateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.ExchangeRate.Create
  alias BudgetApp.ExchangeRate
  alias BudgetApp.Repo

  test "saves record to DB" do
    assert Repo.aggregate(ExchangeRate, :count, :id) == 0
    eur = insert(:currency, name: "Euro", iso_code: "EUR")
    rsd = insert(:currency, name: "Serbian dinar", iso_code: "RSD")
    exchange_rate = Create.exec(Date.utc_today(), 118.43, eur.id, rsd.id)
    assert {:ok, %ExchangeRate{}} = exchange_rate
    assert Repo.aggregate(ExchangeRate, :count, :id) == 1
  end

  test "returns error unless date, on which exchange rate has been valid, is given" do
    expected = {:operation_error, "Date is required!"}
    assert expected == Create.exec(nil, nil, nil, nil)
  end

  test "returns error unless rate is given" do
    expected = {:operation_error, "Rate is required!"}
    assert expected == Create.exec(Date.utc_today(), nil, nil, nil)
  end

  test "returns error unless from currency given" do
    expected = {:operation_error, "Currency is required!"}
    assert expected == Create.exec(Date.utc_today(), 120, nil, nil)
  end

  test "returns error unless to currency given" do
    expected = {:operation_error, "Currency is required!"}
    assert expected == Create.exec(Date.utc_today(), 120, 1, nil)
  end
end