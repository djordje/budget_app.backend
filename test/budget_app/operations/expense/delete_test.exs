defmodule BudgetApp.Operations.Expense.DeleteTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Expense.Delete
  alias BudgetApp.Expense
  alias BudgetApp.Repo

  test "removes record from the DB" do
    expense = insert(:expense)
    assert Repo.aggregate(Expense, :count, :id) == 1
    Delete.exec(expense.id)
    assert Repo.aggregate(Expense, :count, :id) == 0
  end

  test "raises exception when expense ID not found" do
    assert {:error, _} = Delete.exec(1)
  end
end