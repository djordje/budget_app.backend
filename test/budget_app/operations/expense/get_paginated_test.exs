defmodule BudgetApp.Operations.Expense.GetPaginatedTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Expense.GetPaginated

  test "returns paginated list" do
    expenses = insert_list(20, :expense)
    {:ok, results} = GetPaginated.exec(1, 10)
    assert results.entries       == Enum.reverse(expenses) |> Enum.take(10)
    assert results.page_number   == 1
    assert results.page_size     == 10
    assert results.total_entries == 20
    assert results.total_pages   == 2
  end

  test "returns empty list when no expenses in the DB" do
    {:ok, results} = GetPaginated.exec(1)
    assert results.entries       == []
    assert results.page_number   == 1
    assert results.page_size     == 10
    assert results.total_entries == 0
    assert results.total_pages   == 1
  end

  test "returns empty list when page number exceeds total entries" do
    insert_list(10, :expense)
    {:ok, results} = GetPaginated.exec(2)
    assert results.entries       == []
    assert results.page_number   == 2
    assert results.page_size     == 10
    assert results.total_entries == 10
    assert results.total_pages   == 1
  end
end