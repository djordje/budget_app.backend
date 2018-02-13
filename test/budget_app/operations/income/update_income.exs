defmodule BudgetApp.Operations.Income.UpdateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Income.Update

  test "saves updated record to the DB" do
    income = insert(:income)
    {:ok, updated_income} = Update.exec(income.id, amount: income.amount + 20)
    assert updated_income.amount == income.amount + 20
  end

  test "returns error when income ID not given" do
    expected = {:operation_error, "Income ID is required!"}
    assert expected == Update.exec(nil, desc: "Test desc")
  end

  test "returns error unless at least one field given" do
    income   = insert(:income)
    expected = {:operation_error, "No fields to update!"}
    assert expected == Update.exec(income.id, test_field: "wrong")
  end

  test "returns error unless expense with given ID exist" do
    expected = {:operation_error, "Income not found!"}
    assert expected == Update.exec(1, desc: "Test desc")
  end
end