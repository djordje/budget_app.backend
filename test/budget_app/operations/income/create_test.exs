defmodule BudgetApp.Operations.Income.CreateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Income.Create
  alias BudgetApp.Income
  alias BudgetApp.Repo

  test "saves record to DB" do
    currency = insert(:currency)
    today    = Date.utc_today()
    assert Repo.aggregate(Income, :count, :id) == 0
    assert {:ok, %Income{}} = Create.exec(today, today, currency.id, 10, "Test desc")
    assert Repo.aggregate(Income, :count, :id) == 1
  end

  test "returns error unless date on which income arrived is given" do
    expected = {:operation_error, "Date is required!"}
    assert expected == Create.exec(nil, nil, nil, nil, nil)
  end

  test "returns error unless date for calculating income is given" do
    expected = {:operation_error, "Date is required!"}
    assert expected == Create.exec(Date.utc_today(), nil, nil, nil, nil)
  end

  test "returns error unless currency of income is given" do
    today    = Date.utc_today()
    expected = {:operation_error, "Currency is required!"}
    assert expected == Create.exec(today, today, nil, nil, nil)
  end

  test "returns error unless amount of income is given" do
    today    = Date.utc_today()
    expected = {:operation_error, "Amount is required!"}
    assert expected == Create.exec(today, today, 1, nil, nil)
  end

  test "returns ecto errors if something goes wrong" do
    today = Date.utc_today()
    assert {:error, _} = Create.exec(today, today, 1, 10, nil)
  end
end