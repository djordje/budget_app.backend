defmodule BudgetApp.Operations.Income.DeleteTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Income.Delete
  alias BudgetApp.Income
  alias BudgetApp.Repo

  test "removes record from the DB" do
    expense = insert(:income)
    assert Repo.aggregate(Income, :count, :id) == 1
    Delete.exec(expense.id)
    assert Repo.aggregate(Income, :count, :id) == 0
  end

  test "raises exception when income ID not found" do
    assert {:error, _} = Delete.exec(1)
  end
end