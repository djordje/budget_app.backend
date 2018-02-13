defmodule BudgetApp.Operations.Currency.DeleteTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Currency.Delete
  alias BudgetApp.Currency
  alias BudgetApp.Repo

  test "removes record from the DB" do
    currency = insert(:currency)
    assert Repo.aggregate(Currency, :count, :id) == 1
    Delete.exec(currency.id)
    assert Repo.aggregate(Currency, :count, :id) == 0
  end

  test "raises exception when currency ID not found" do
    assert {:error, _} = Delete.exec(1)
  end
end