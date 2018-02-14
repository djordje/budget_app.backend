defmodule BudgetApp.Operations.ExchangeRate.UpdateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.ExchangeRate.Update

  test "saves updated record to the DB" do
    exchange_rate = insert(:exchange_rate)
    {:ok, exchange_rate} = Update.exec(exchange_rate.id, rate: 100)
    assert exchange_rate.rate == 100
  end

  test "returns error when exchange rate ID not given" do
    expected = {:operation_error, "Exchange rate ID is required!"}
    assert expected == Update.exec(nil, rate: 100)
  end

  test "returns error unless at least one field given" do
    exchange_rate = insert(:exchange_rate)
    expected = {:operation_error, "No fields to update!"}
    assert expected == Update.exec(exchange_rate.id, test_field: "wrong")
  end

  test "returns error unless exchange rate with given ID exist" do
    expected = {:operation_error, "Exchange rate not found!"}
    assert expected == Update.exec(1, rate: 100)
  end
end