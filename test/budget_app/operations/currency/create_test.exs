defmodule BudgetApp.Operations.Currency.CreateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Currency.Create
  alias BudgetApp.Currency
  alias BudgetApp.Repo

  test "saves record to DB" do
    assert Repo.aggregate(Currency, :count, :id) == 0
    assert {:ok, %Currency{}} = Create.exec("Serbian dinar", "RSD")
    assert Repo.aggregate(Currency, :count, :id) == 1
  end

  test "returns error unless name given" do
    expected = {:operation_error, "Name is required!"}
    assert expected == Create.exec(nil, nil)
  end

  test "returns error unless ISO code given" do
    expected = {:operation_error, "ISO code is required!"}
    assert expected == Create.exec("Serbian dinar", nil)
  end

  test "returns ecto validation errors if there is violation" do
    assert {:error, _} = Create.exec("Serbian dinar", "TOO LONG")
  end
end