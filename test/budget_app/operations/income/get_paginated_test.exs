defmodule BudgetApp.Operations.Income.GetPaginatedTest do
  use BudgetAppWeb.ConnCase, async: true

  alias BudgetApp.Operations.Income.GetPaginated

  test "returns paginated list" do
    incomes = insert_list(20, :income)
    {:ok, results} = GetPaginated.exec(1, 10)
    assert results.entries       == Enum.reverse(incomes) |> Enum.take(10)
    assert results.page_number   == 1
    assert results.page_size     == 10
    assert results.total_entries == 20
    assert results.total_pages   == 2
  end

  test "returns empty list when no incomes in the DB" do
    {:ok, results} = GetPaginated.exec(1)
    assert results.entries       == []
    assert results.page_number   == 1
    assert results.page_size     == 10
    assert results.total_entries == 0
    assert results.total_pages   == 1
  end

  test "returns empty list when page number exceeds total entries" do
    insert_list(10, :income)
    {:ok, results} = GetPaginated.exec(2)
    assert results.entries       == []
    assert results.page_number   == 2
    assert results.page_size     == 10
    assert results.total_entries == 10
    assert results.total_pages   == 1
  end
end