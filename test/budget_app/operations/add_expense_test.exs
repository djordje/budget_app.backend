defmodule BudgetApp.Operations.AddExpenseTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.AddExpense
  alias BudgetApp.Expense
  alias BudgetApp.Repo
  
  test "saves record to the DB" do
    currency = insert(:currency)
    assert Repo.aggregate(Expense, :count, :id) == 0
    AddExpense.exec(Date.utc_today, currency.id, 10, "Test desc")
    assert Repo.aggregate(Expense, :count, :id) == 1
  end

  test "returns error unless date of spending is given" do
    expected = {:error, "Date is required!"}
    assert expected == AddExpense.exec(nil, nil, nil, nil)
  end

  test "returns error unless currency of spending is given" do
    expected = {:error, "Currency is required!"}
    assert expected == AddExpense.exec(Date.utc_today(), nil, nil, nil)
  end

  test "returns error unless amount of spending is given" do
    expected = {:error, "Amount is required!"}
    assert expected == AddExpense.exec(Date.utc_today(), 1, nil, nil)
  end

  test "returns ecto errors if something goes wrong" do
    assert {:error, _} = AddExpense.exec(Date.utc_today(), 1, 10, nil)
  end
end