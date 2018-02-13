defmodule BudgetApp.Operations.Currency.UpdateTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Currency.Update

  test "saves updated record to the DB" do
    currency = insert(:currency)
    {:ok, updated_currency} = Update.exec(currency.id, iso_code: "RSD")
    assert updated_currency.iso_code == "RSD"
  end

  test "returns error when currency ID not given" do
    expected = {:operation_error, "Currency ID is required!"}
    assert expected == Update.exec(nil, iso_code: "RSD")
  end

  test "returns error unless at least one field given" do
    currency = insert(:currency)
    expected = {:operation_error, "No fields to update!"}
    assert expected == Update.exec(currency.id, test_field: "wrong")
  end

  test "returns error unless currency with given ID exist" do
    expected = {:operation_error, "Currency not found!"}
    assert expected == Update.exec(1, iso_code: "RSD")
  end
end