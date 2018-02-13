defmodule BudgetApp.Operations.Expense.UpdateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Expense.Update

  test "saves updated record to the DB" do
    expense = insert(:expense)
    {:ok, updated_expense} = Update.exec(expense.id, amount: expense.amount + 20)
    assert updated_expense.amount == expense.amount + 20
  end

  test "returns error when expense ID not given" do
    expected = {:operation_error, "Expense ID is required!"}
    assert expected == Update.exec(nil, desc: "Test desc")
  end

  test "returns error unless at least one field given" do
    expense  = insert(:expense)
    expected = {:operation_error, "No fields to update!"}
    assert expected == Update.exec(expense.id, test_field: "wrong")
  end

  test "returns error unless expense with given ID exist" do
    expected = {:operation_error, "Expense not found!"}
    assert expected == Update.exec(1, desc: "Test desc")
  end
end