defmodule BudgetApp.Components.FilterFieldsTest do
  use ExUnit.Case, async: true

  alias BudgetApp.Components.FilterFields

  test "returns filtered map containing key value pairs" do
    result   = FilterFields.exec(
      [:first_name, :last_name],
      %{first_name: "Djordje", last_name: "Kovacevic", gender: "M"}
    )
    expected = {:ok, %{first_name: "Djordje", last_name: "Kovacevic"}}
    assert result == expected
  end

  test "returns filtered map containing key value pars when it gets keyword list as a input" do
    result   = FilterFields.exec(
      [:first_name, :last_name],
      first_name: "Djordje", last_name: "Kovacevic", gender: "M"
    )
    expected = {:ok, %{first_name: "Djordje", last_name: "Kovacevic"}}
    assert result == expected
  end

  test "returns error when `fields_to_get` not a list" do
    assert {:error, _} = FilterFields.exec(nil, %{})
  end

  test "returns error when `map` not a list or a map" do
    assert {:error, _} = FilterFields.exec([], nil)
  end
end