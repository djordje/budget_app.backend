defmodule BudgetApp.Operations.Expense.CreateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Expense.Create
  alias BudgetApp.Expense
  alias BudgetApp.Repo
  
  test "saves record to the DB" do
    currency = insert(:currency)
    assert Repo.aggregate(Expense, :count, :id) == 0
    {:ok, %Expense{} = expense} = Create.exec(Date.utc_today, currency.id, 10, "Test desc")
    assert expense.currency_id == currency.id
    assert Repo.aggregate(Expense, :count, :id) == 1
  end

  test "returns error unless date of spending is given" do
    expected = {:operation_error, "Date is required!"}
    assert expected == Create.exec(nil, nil, nil, nil)
  end

  test "returns error unless currency of spending is given" do
    expected = {:operation_error, "Currency is required!"}
    assert expected == Create.exec(Date.utc_today(), nil, nil, nil)
  end

  test "returns error unless amount of spending is given" do
    expected = {:operation_error, "Amount is required!"}
    assert expected == Create.exec(Date.utc_today(), 1, nil, nil)
  end

  test "returns ecto errors if something goes wrong" do
    assert {:error, _} = Create.exec(Date.utc_today(), 1, 10, nil)
  end
end